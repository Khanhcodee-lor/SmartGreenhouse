const { onValueUpdated } = require("firebase-functions/v2/database");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const admin = require("firebase-admin");

admin.initializeApp();

// Hàm hỗ trợ gửi thông báo tới tất cả các thiết bị đã đăng ký
async function sendNotification(title, body) {
  const db = admin.database();
  const tokensSnapshot = await db.ref("fcmTokens").once("value");

  if (!tokensSnapshot.exists()) {
    console.log("No FCM tokens found.");
    return;
  }

  const tokensObj = tokensSnapshot.val();
  const tokens = Object.keys(tokensObj); // Lấy danh sách token

  if (tokens.length === 0) return;

  const payload = {
    notification: {
      title: title,
      body: body,
    },
    tokens: tokens,
  };

  try {
    const response = await admin.messaging().sendEachForMulticast(payload);
    console.log(`Successfully sent message: ${response.successCount} messages were sent successfully`);
  } catch (error) {
    console.error("Error sending message:", error);
  }
}

// 1. Cảnh báo mất kết nối
exports.onDeviceOnlineChanged = onValueUpdated(
  { ref: "/smart_greenhouse/device/online" },
  async (event) => {
    const isOnlineBefore = event.data.before.val();
    const isOnlineAfter = event.data.after.val();

    if (isOnlineBefore === true && isOnlineAfter === false) {
      await sendNotification(
        "Cảnh báo kết nối ⚠️",
        "Hệ thống nhà kính vừa bị mất kết nối! Vui lòng kiểm tra lại nguồn điện và WiFi."
      );
    }
  }
);

// 2. Thông báo máy bơm
exports.onPumpChanged = onValueUpdated(
  { ref: "/smart_greenhouse/actuators/pump" },
  async (event) => {
    const pumpBefore = event.data.before.val();
    const pumpAfter = event.data.after.val();

    if (pumpBefore === false && pumpAfter === true) {
      await sendNotification("Trạng thái Máy Bơm 🚰", "Máy bơm đã được BẬT.");
    } else if (pumpBefore === true && pumpAfter === false) {
      await sendNotification("Trạng thái Máy Bơm 🚰", "Máy bơm đã được TẮT.");
    }
  }
);

// 3. Cảnh báo cảm biến (Nhiệt độ, Độ ẩm, Đất)
exports.onSensorsChanged = onValueUpdated(
  { ref: "/smart_greenhouse/sensors" },
  async (event) => {
    const before = event.data.before.val();
    const after = event.data.after.val();

    if (!before || !after) return;

    // --- ĐỘ ẨM ĐẤT ---
    // Cảnh báo nếu trước đó >= 30 và bây giờ < 30 (chỉ báo lúc vừa tụt xuống để tránh spam)
    if (before.soilMoisture >= 30 && after.soilMoisture < 30) {
      await sendNotification(
        "Cảnh báo đất khô 🏜️",
        `Độ ẩm đất hiện tại quá thấp (${after.soilMoisture}%). Cây đang thiếu nước nghiêm trọng!`
      );
    }

    // --- NHIỆT ĐỘ ---
    if (before.temperature <= 40 && after.temperature > 40) {
      await sendNotification(
        "Cảnh báo nhiệt độ cao 🔥",
        `Nhiệt độ nhà kính quá nóng (${after.temperature}°C)!`
      );
    } else if (before.temperature >= 10 && after.temperature < 10) {
      await sendNotification(
        "Cảnh báo nhiệt độ thấp ❄️",
        `Nhiệt độ nhà kính quá lạnh (${after.temperature}°C)!`
      );
    }

    // --- ĐỘ ẨM KHÔNG KHÍ ---
    if (before.humidity >= 30 && after.humidity < 30) {
      await sendNotification(
        "Cảnh báo độ ẩm không khí 🌵",
        `Độ ẩm không khí quá khô (${after.humidity}%)!`
      );
    } else if (before.humidity <= 90 && after.humidity > 90) {
      await sendNotification(
        "Cảnh báo độ ẩm không khí 💧",
        `Độ ẩm không khí quá cao (${after.humidity}%)!`
      );
    }
  }
);

// 4. Cảnh báo mất kết nối cảm biến (Lỗi phần cứng)
exports.onSensorDisconnected = onValueUpdated(
  { ref: "/smart_greenhouse/sensors/disconnected" },
  async (event) => {
    const before = event.data.before.val();
    const after = event.data.after.val();

    if (!before || !after) return;

    // Hàm hỗ trợ dịch tên cảm biến
    const getSensorName = (list) => {
      if (!list) return "không xác định";
      const listStr = String(list).toLowerCase();
      if (listStr.includes("soil")) return "độ ẩm đất";
      if (listStr.includes("dht")) return "nhiệt độ/độ ẩm";
      if (listStr.includes("light")) return "ánh sáng";
      if (listStr.includes("flow")) return "lưu lượng nước";
      return list;
    };

    // Mất kết nối
    if (before.any !== true && after.any === true) {
      const sensorName = getSensorName(after.list);
      await sendNotification(
        "Cảnh báo Lỗi Cảm Biến ⚠️",
        `Phát hiện mất kết nối với cảm biến ${sensorName}! Vui lòng kiểm tra lại mạch điện.`
      );
    } 
    // Kết nối lại thành công
    else if (before.any === true && after.any !== true) {
      const sensorName = getSensorName(before.list); // Lấy tên từ state cũ bị lỗi
      await sendNotification(
        "Cảm biến đã khôi phục ✅",
        `Kết nối với cảm biến ${sensorName} đã hoạt động bình thường trở lại.`
      );
    }
  }
);

// 5. Quét Heartbeat mỗi phút để phát hiện thiết bị sập nguồn/mất mạng
exports.checkDeviceHeartbeat = onSchedule("every 1 minutes", async (event) => {
  const db = admin.database();
  const deviceRef = db.ref("/smart_greenhouse/device");
  
  const snapshot = await deviceRef.once("value");
  if (!snapshot.exists()) return;
  
  const data = snapshot.val();
  const lastHeartbeat = data.lastHeartbeat || 0;
  const isOnline = data.online;
  
  const now = Date.now();
  const TWO_MINUTES = 2 * 60 * 1000; // Ngưỡng an toàn là 2 phút
  
  // Nếu thiết bị đang online nhưng heartbeat đã cũ quá 2 phút => ESP32 đã chết (mất nguồn/mất WiFi)
  if (isOnline && (now - lastHeartbeat > TWO_MINUTES)) {
    console.log(`Phát hiện thiết bị offline. now=${now}, lastHeartbeat=${lastHeartbeat}. Set online = false.`);
    // Đổi state sang false. Việc này sẽ kích hoạt hàm exports.onDeviceOnlineChanged để gửi thông báo.
    await deviceRef.child("online").set(false);
  }
});

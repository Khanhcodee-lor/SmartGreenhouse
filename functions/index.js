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

// 1. Cảnh báo mất kết nối và kết nối lại
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
    } else if (isOnlineBefore === false && isOnlineAfter === true) {
      await sendNotification(
        "Đã kết nối lại ✅",
        "Hệ thống nhà kính đã trực tuyến và hoạt động bình thường."
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

// Thông báo Đèn chiếu sáng
exports.onLightChanged = onValueUpdated(
  { ref: "/smart_greenhouse/actuators/light" },
  async (event) => {
    const lightBefore = event.data.before.val();
    const lightAfter = event.data.after.val();

    if (lightBefore === false && lightAfter === true) {
      await sendNotification("Trạng thái Đèn 💡", "Đèn chiếu sáng đã được BẬT.");
    } else if (lightBefore === true && lightAfter === false) {
      await sendNotification("Trạng thái Đèn 💡", "Đèn chiếu sáng đã được TẮT.");
    }
  }
);

// Thông báo Quạt thông gió
exports.onFanChanged = onValueUpdated(
  { ref: "/smart_greenhouse/actuators/fan" },
  async (event) => {
    const fanBefore = event.data.before.val();
    const fanAfter = event.data.after.val();

    if (fanBefore === false && fanAfter === true) {
      await sendNotification("Trạng thái Quạt 🌬️", "Quạt thông gió đã được BẬT.");
    } else if (fanBefore === true && fanAfter === false) {
      await sendNotification("Trạng thái Quạt 🌬️", "Quạt thông gió đã được TẮT.");
    }
  }
);

// 3. Cảnh báo cảm biến (Nhiệt độ, Độ ẩm, Đất, Ánh sáng)
exports.onSensorsChanged = onValueUpdated(
  { ref: "/smart_greenhouse/sensors" },
  async (event) => {
    const before = event.data.before.val();
    const after = event.data.after.val();

    if (!before || !after) return;

    // Lấy các ngưỡng (thresholds) từ Firebase
    const db = admin.database();
    const controlSnap = await db.ref("/smart_greenhouse/control").once("value");
    const control = controlSnap.val() || {};
    
    const soilThreshold = control.soilThreshold || 60;
    const tempThreshold = control.tempThreshold || 40;
    const humidityThreshold = control.humidityThreshold || 30;

    // --- ĐỘ ẨM ĐẤT ---
    if (before.soilMoisture >= soilThreshold && after.soilMoisture < soilThreshold) {
      await sendNotification(
        "Cảnh báo đất khô 🏜️",
        `Độ ẩm đất hiện tại quá thấp (${after.soilMoisture}%). Cây đang thiếu nước nghiêm trọng!`
      );
    } else if (before.soilMoisture < soilThreshold && after.soilMoisture >= soilThreshold) {
      await sendNotification(
        "Đất đã đủ ẩm 🌱",
        `Độ ẩm đất đã đạt mức ổn định (${after.soilMoisture}%).`
      );
    }

    // --- NHIỆT ĐỘ ---
    if (before.temperature <= tempThreshold && after.temperature > tempThreshold) {
      await sendNotification(
        "Cảnh báo nhiệt độ cao 🔥",
        `Nhiệt độ nhà kính quá nóng (${after.temperature}°C)!`
      );
    } else if (before.temperature >= 10 && after.temperature < 10) {
      await sendNotification(
        "Cảnh báo nhiệt độ thấp ❄️",
        `Nhiệt độ nhà kính quá lạnh (${after.temperature}°C)!`
      );
    } else if ((before.temperature > tempThreshold || before.temperature < 10) && (after.temperature >= 10 && after.temperature <= tempThreshold)) {
      await sendNotification(
        "Nhiệt độ ổn định 🌡️",
        `Nhiệt độ đã trở lại mức bình thường (${after.temperature}°C).`
      );
    }

    // --- ĐỘ ẨM KHÔNG KHÍ ---
    if (before.humidity >= humidityThreshold && after.humidity < humidityThreshold) {
      await sendNotification(
        "Cảnh báo không khí khô 🌵",
        `Độ ẩm không khí quá khô (${after.humidity}%)!`
      );
    } else if (before.humidity <= 90 && after.humidity > 90) {
      await sendNotification(
        "Cảnh báo độ ẩm cao 💧",
        `Độ ẩm không khí quá cao (${after.humidity}%)!`
      );
    } else if ((before.humidity < humidityThreshold || before.humidity > 90) && (after.humidity >= humidityThreshold && after.humidity <= 90)) {
      await sendNotification(
        "Độ ẩm không khí ổn định ☁️",
        `Độ ẩm không khí đã trở lại mức bình thường (${after.humidity}%).`
      );
    }

    // --- ÁNH SÁNG ---
    if (before.lightLevel >= 20 && after.lightLevel < 20) {
      await sendNotification(
        "Cảnh báo thiếu sáng 🌥️",
        `Cường độ ánh sáng quá thấp (${after.lightLevel}%).`
      );
    } else if (before.lightLevel < 20 && after.lightLevel >= 20) {
      await sendNotification(
        "Ánh sáng ổn định ☀️",
        `Cường độ ánh sáng đã đủ (${after.lightLevel}%).`
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

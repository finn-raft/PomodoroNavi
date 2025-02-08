document.addEventListener('turbolinks:load', () => {
  let workDuration, shortBreakDuration, longBreakDuration, longBreakCycle;
  let autoStartWork, autoStartBreak, alarmOn;
  let currentMinutes, currentSeconds;
  let isWorking = true;
  let timer = null;
  let startTime = null;
  let elapsedTime = 0;
  let cycleCount = 0;

  const timerElement = document.getElementById('timer');
  const statusElement = document.getElementById('status');
  const startStopButton = document.getElementById('start-stop');
  const endButton = document.getElementById('end');
  const alarmSound = document.getElementById('alarm-sound');

  // ポモドーロ設定ページからデータを取得する
  function fetchSettings() {
    return fetch('/pomodoro_settings/show')
      .then(response => { // 未ログインユーザーの場合はデフォルト値を取得
        if (response.status === 401 || response.status === 404) {
          return fetch('/default_pomodoro_settings');
        }
        return response;
      })
      .then(response => response.json())
      .then(data => {
        workDuration = data.work_duration;
        shortBreakDuration = data.short_break_duration;
        longBreakDuration = data.long_break_duration;
        longBreakCycle = data.long_break_cycle;
        autoStartWork = data.auto_start_work;
        autoStartBreak = data.auto_start_break;
        alarmOn = data.alarm_on;
        currentMinutes = workDuration;
        currentSeconds = 0;
        updateTimerDisplay();
      })
      .catch(error => {
        console.error('Error fetching settings:', error);
        workDuration = 25;
        shortBreakDuration = 5;
        longBreakDuration = 15;
        longBreakCycle = 4;
        autoStartWork = true;
        autoStartBreak = true;
        alarmOn = true;
        currentMinutes = workDuration;
        currentSeconds = 0;
        updateTimerDisplay();
      });
  }

  // ブラウザのタブにタイマーの残り時間を表示する
  function updateTimerDisplay() {
    const minutes = String(currentMinutes).padStart(2, '0');
    const seconds = String(currentSeconds).padStart(2, '0');
    timerElement.textContent = `${minutes}:${seconds}`;

    // タイマー動作中のみタイトル更新
    if (timer !== null) {
      document.title = `PomodoroNavi ${minutes}:${seconds}`;
    } else {
      document.title = 'PomodoroNavi';
    }
  }

  // タイマーのモード（「作業中」「休憩中」「長い休憩中」）を切り替える
  function switchMode() {
    if (isWorking) {
      cycleCount++;
      if (cycleCount % longBreakCycle === 0) {
        currentMinutes = longBreakDuration;
        statusElement.textContent = '長い休憩中';
      } else {
        currentMinutes = shortBreakDuration;
        statusElement.textContent = '休憩中';
      }
      if (autoStartBreak) {
        startTimer();
      } else {
        stopTimer();
      }
    } else {
      currentMinutes = workDuration;
      statusElement.textContent = '作業中';
      if (autoStartWork) {
        startTimer();
      } else {
        stopTimer();
      }
    }
    currentSeconds = 0;
    isWorking = !isWorking;
    startTime = new Date();
    elapsedTime = 0;
    updateTimerDisplay();
  }

  // アラーム音を再生する
  function playAlarm() {
    if (alarmOn) {
      alarmSound.play();
    }
  }

  // タイマーのカウントダウン処理
  function tick() {
    const now = new Date();
    const elapsed = Math.floor((now - startTime) / 1000) + elapsedTime;
    const totalInitialSeconds = (isWorking ? workDuration : (cycleCount % longBreakCycle === 0 ? longBreakDuration : shortBreakDuration)) * 60;
    const remainingSeconds = totalInitialSeconds - elapsed;

    if (remainingSeconds <= 0) {
      playAlarm();
      switchMode();
    } else {
      currentMinutes = Math.floor(remainingSeconds / 60);
      currentSeconds = remainingSeconds % 60;
      updateTimerDisplay();
    }
  }

  // タイマーの開始処理
  function startTimer() {
    if (timer === null) {
      startTime = new Date();
      timer = setInterval(tick, 1000);
      startStopButton.textContent = 'Stop';

      // 長い休憩中、通常休憩中、作業中を正確に表示
      if (!isWorking && cycleCount % longBreakCycle === 0) {
        statusElement.textContent = '長い休憩中';
      } else {
        statusElement.textContent = isWorking ? '作業中' : '休憩中';
      }
    }
  }

  // タイマーの停止処理
  function stopTimer() {
    if (timer !== null) {
      clearInterval(timer);
      timer = null;
      elapsedTime += Math.floor((new Date() - startTime) / 1000);
      startStopButton.textContent = 'Start';
      document.title = 'PomodoroNavi';
    }
  }

  // タイマーのリセット処理
  function resetTimer() {
    stopTimer();
    currentMinutes = workDuration;
    currentSeconds = 0;
    isWorking = true;
    cycleCount = 0;
    elapsedTime = 0;
    statusElement.textContent = '';
    updateTimerDisplay();
    document.title = 'PomodoroNavi';
  }

  // ボタンクリック時の処理
  startStopButton.addEventListener('click', () => {
    if (timer === null) {
      startTimer();
    } else {
      stopTimer();
    }
  });

  endButton.addEventListener('click', () => {
    resetTimer();
  });

  // ページ遷移時にタイマーをクリア
  document.addEventListener('turbolinks:before-cache', () => {
    if (timer !== null) {
      clearInterval(timer);
    }
  });

  fetchSettings();
});
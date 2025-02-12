document.addEventListener('turbolinks:load', () => {
  let workDuration, shortBreakDuration, longBreakDuration, longBreakCycle;
  let autoStartWork, autoStartBreak, alarmOn;
  let currentMinutes, currentSeconds;
  let isWorking = true;
  let timer = null;
  let startTime = null;
  let elapsedWorkTime = 0; // 作業時間の合計（レポート用）
  let elapsedBreakTime = 0; // 休憩時間の合計（レポート用）
  let cycleCount = 0;
  let pausedTime = 0; // 一時停止時刻（再開時に経過時間を調整するため）
  let isPaused = false; // 一時停止中かどうか（再開時に経過時間を調整するため）
  let isEnded = false; // タイマーが終了したかどうか（終了時にセッションを記録するため）

  const timerElement = document.getElementById('timer');
  const statusElement = document.getElementById('status');
  const startStopButton = document.getElementById('start-stop');
  const endButton = document.getElementById('end');
  const alarmSound = document.getElementById('alarm-sound');

  // ポモドーロ設定ページからデータを取得する
  function fetchSettings() {
    return fetch('/pomodoro_settings/show')
      .then(response => {
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
        fetchSpecificMessage(8, cycleCount, Math.floor(elapsedWorkTime / 60), "+++ 現在のポモドーロの経過 +++");
      } else {
        currentMinutes = shortBreakDuration;
        statusElement.textContent = '休憩中';
        fetchSpecificMessage(8, cycleCount, Math.floor(elapsedWorkTime / 60), "+++ 現在のポモドーロの経過 +++");
      }
      if (autoStartBreak) {
        startTimer();
      } else {
        stopTimer();
      }
    } else {
      currentMinutes = workDuration;
      statusElement.textContent = '作業中';
      fetchSpecificMessage(7);
      if (autoStartWork) {
        startTimer();
      } else {
        stopTimer();
      }
    }
    currentSeconds = 0;
    isWorking = !isWorking;
    startTime = new Date();
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
    const elapsed = Math.floor((now - startTime) / 1000);
    const totalInitialSeconds = (isWorking ? workDuration : (cycleCount % longBreakCycle === 0 ? longBreakDuration : shortBreakDuration)) * 60;
    const remainingSeconds = totalInitialSeconds - elapsed;

    if (remainingSeconds <= 0) {
      playAlarm();
      if (isWorking) {
        elapsedWorkTime += totalInitialSeconds;
      } else {
        elapsedBreakTime += totalInitialSeconds;
      }
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
      if (isPaused && !isEnded) {
        startTime = new Date(startTime.getTime() + (new Date().getTime() - pausedTime));
        isPaused = false;
      } else {
        startTime = new Date();
        isEnded = false;
      }
      timer = setInterval(tick, 1000);
      startStopButton.textContent = 'Stop';

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
      pausedTime = new Date();
      isPaused = true;
      timer = null;
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
    elapsedWorkTime = 0;
    elapsedBreakTime = 0;
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
    stopTimer();
    const now = new Date();
    const elapsed = Math.floor((now - startTime) / 1000);
    if (isWorking) {
      elapsedWorkTime += elapsed;
    } else {
      elapsedBreakTime += elapsed;
    }
    isEnded = true;
    fetchSpecificMessage(9, cycleCount, Math.floor(elapsedWorkTime / 60), "+++ 今回のポモドーロの結果 +++");
    recordSession().finally(() => {
      resetTimer();
    });
  });

  // ページ遷移時にタイマーをクリア
  document.addEventListener('turbolinks:before-cache', () => {
    if (timer !== null) {
      clearInterval(timer);
    }
  });

  // セッションを記録する
  function recordSession() {
    const endTime = new Date();
    const workDuration = Math.floor(elapsedWorkTime / 60);
    const breakDuration = Math.floor(elapsedBreakTime / 60);

    return fetch('/pomodoro_sessions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        pomodoro_session: {
          start_time: startTime,
          end_time: endTime,
          duration: workDuration,
          break_duration: breakDuration,
          status: 'completed',
          mode: isWorking ? 'work' : 'break'
        }
      })
    }).then(response => {
      if (!response.ok) throw new Error('Network response was not ok');
      return response.json();
    }).then(data => {
      console.log('Session recorded:', data);
    }).catch(error => {
      console.error('Error recording session:', error);
    });
  }

  // ナビのメッセージを表示する
  function fetchSpecificMessage(id, cycles = null, totalWorkTime = null, additionalMessage = "") {
    let url = `/navi_messages/${id}`;
    if (cycles !== null) url += `?cycles=${cycles}`;
    if (totalWorkTime !== null) url += `&totalWorkTime=${totalWorkTime}`;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        const naviMessageElement = document.getElementById('navi-message');
        if (naviMessageElement) {
          naviMessageElement.innerHTML = `
            <p>${data.response}</p>
            <p>${additionalMessage}</p>
            ${cycles !== null ? `<p>▼ ポモドーロサイクル: ${cycles} 回</p>` : ''}
            ${totalWorkTime !== null ? `<p>▼ 作業時間合計: ${totalWorkTime} 分</p>` : ''}
          `;
        }
      });
  }

  fetchSettings();
});
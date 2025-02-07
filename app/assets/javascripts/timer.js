document.addEventListener('turbolinks:load', () => {
  let workDuration, shortBreakDuration, longBreakDuration, longBreakCycle;
  let autoStartWork, autoStartBreak;
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
              currentMinutes = workDuration;
              currentSeconds = 0;
              updateTimerDisplay();
          });
  }

  function updateTimerDisplay() {
      const minutes = String(currentMinutes).padStart(2, '0');
      const seconds = String(currentSeconds).padStart(2, '0');
      timerElement.textContent = `${minutes}:${seconds}`;
      if (timer !== null) {
          document.title = `PomodoroNavi ${minutes}:${seconds}`;
      }
  }

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

  function playAlarm() {
      alarmSound.play();
  }

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

  function startTimer() {
      if (timer === null) {
          startTime = new Date();
          timer = setInterval(tick, 1000);
          startStopButton.textContent = 'Stop';
          statusElement.textContent = isWorking ? '作業中' : '休憩中';
      }
  }

  function stopTimer() {
      if (timer !== null) {
          clearInterval(timer);
          timer = null;
          elapsedTime += Math.floor((new Date() - startTime) / 1000);
          startStopButton.textContent = 'Start';
      }
  }

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

  fetchSettings();
});
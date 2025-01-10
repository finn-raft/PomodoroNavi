document.addEventListener('turbolinks:load', () => {
    const initialWorkMinutes = 25;
    const initialBreakMinutes = 5;
    let currentMinutes = initialWorkMinutes;
    let currentSeconds = 0;
    let isWorking = true;
    let timer = null;
    let startTime = null;
    let elapsedTime = 0;  // 経過時間を保存する変数

    const timerElement = document.getElementById('timer');
    const statusElement = document.getElementById('status');
    const startStopButton = document.getElementById('start-stop');
    const endButton = document.getElementById('end');
    const alarmSound = document.getElementById('alarm-sound');

    function updateTimerDisplay() {
        const minutes = String(currentMinutes).padStart(2, '0');
        const seconds = String(currentSeconds).padStart(2, '0');
        timerElement.textContent = `${minutes}:${seconds}`;
        if (timer !== null) { // タイマーが動いている場合のみタイトルにカウントダウンを表示する
            document.title = `PomodoroNavi ${minutes}:${seconds}`;
        }
    }

    function switchMode() {
        if (isWorking) {
            currentMinutes = initialBreakMinutes;
            statusElement.textContent = '休憩中';
        } else {
            currentMinutes = initialWorkMinutes;
            statusElement.textContent = '作業中';
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
        const elapsed = Math.floor((now - startTime) / 1000) + elapsedTime; // 経過時間を考慮
        const totalInitialSeconds = (isWorking ? initialWorkMinutes : initialBreakMinutes) * 60;
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
            elapsedTime += Math.floor((new Date() - startTime) / 1000); // 一時停止時の経過時間を保存
            startStopButton.textContent = 'Start';
        }
    }

    function resetTimer() {
        stopTimer();
        currentMinutes = initialWorkMinutes;
        currentSeconds = 0;
        isWorking = true;
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

    updateTimerDisplay();
});
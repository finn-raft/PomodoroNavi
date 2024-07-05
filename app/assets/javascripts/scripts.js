document.addEventListener('DOMContentLoaded', () => {
    const initialWorkMinutes = 25;
    const initialBreakMinutes = 5;
    let currentMinutes = initialWorkMinutes;
    let currentSeconds = 0;
    let isWorking = true;
    let timer = null;

    const timerElement = document.getElementById('timer');
    const statusElement = document.getElementById('status');
    const startStopButton = document.getElementById('start-stop');
    const endButton = document.getElementById('end');
    const alarmSound = document.getElementById('alarm-sound');

    function updateTimerDisplay() {
        const minutes = String(currentMinutes).padStart(2, '0');
        const seconds = String(currentSeconds).padStart(2, '0');
        timerElement.textContent = `${minutes}:${seconds}`;
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
        updateTimerDisplay();
    }

    function playAlarm() {
        alarmSound.play();
    }

    function tick() {
        if (currentSeconds === 0) {
            if (currentMinutes === 0) {
                playAlarm();
                switchMode();
            } else {
                currentMinutes--;
                currentSeconds = 59;
            }
        } else {
            currentSeconds--;
        }
        updateTimerDisplay();
    }

    function startTimer() {
        if (timer === null) {
            timer = setInterval(tick, 1000);
            startStopButton.textContent = 'Stop';
            statusElement.textContent = isWorking ? '作業中' : '休憩中';
        }
    }

    function stopTimer() {
        if (timer !== null) {
            clearInterval(timer);
            timer = null;
            startStopButton.textContent = 'Start';
        }
    }

    function resetTimer() {
        stopTimer();
        currentMinutes = initialWorkMinutes;
        currentSeconds = 0;
        isWorking = true;
        statusElement.textContent = '';
        updateTimerDisplay();
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
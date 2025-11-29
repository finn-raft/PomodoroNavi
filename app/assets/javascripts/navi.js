document.addEventListener('turbolinks:load', function() {
    const naviMessageDiv = document.getElementById("navi-message");
    const userMessageForm = document.getElementById("usermessage_form");

    if (!naviMessageDiv || !userMessageForm) return;

    // 既存のイベントリスナーを削除
    userMessageForm.removeEventListener("submit", handleFormSubmit);
    // 新しいイベントリスナーを追加
    userMessageForm.addEventListener("submit", handleFormSubmit);

    /**
     * ユーザーのメッセージフォームの送信を処理する
     */
    function handleFormSubmit(event) {
        event.preventDefault();
        const userInput = document.getElementById("user_input").value;
        if (userInput.trim() === "") return;

        fetchAIResponse(userInput);
        document.getElementById("user_input").value = "";
    }

    /**
     * AIナビからの応答を取得してメッセージウィンドウに表示する
     */
    function fetchAIResponse(userInput) {
        fetch("/openai_navis/respond", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
            },
            body: JSON.stringify({ openai_navi: { user_input: userInput } })
        })
        .then(response => response.json())
        .then(data => {
            if (data.text) {
                appendMessage(data.text);
            }
        })
        .catch(error => console.error('Error:', error));
    }

    /**
     * ナビメッセージウィンドウにメッセージを追加する
     */
    function appendMessage(message) {
        naviMessageDiv.innerHTML = `<p>${message}</p>`;
    }
});
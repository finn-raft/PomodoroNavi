document.addEventListener('turbolinks:load', function() {
    const naviMessageDiv = document.getElementById("navi-message");
    const userMessageForm = document.getElementById("usermessage_form");

    userMessageForm.addEventListener("submit", function(event) {
        event.preventDefault();
        const userInput = document.getElementById("user_input").value;
        if (userInput.trim() === "") return;

        fetchAIResponse(userInput);
        document.getElementById("user_input").value = "";
    });

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

    function appendMessage(message) {
        naviMessageDiv.innerHTML = `<p>${message}</p>`;
    }
});
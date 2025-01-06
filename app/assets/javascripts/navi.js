document.addEventListener("DOMContentLoaded", function() {
    const naviMessageDiv = document.getElementById("navi-message");

    document.getElementById("usermessage_form").addEventListener("submit", function(event) {
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
            body: JSON.stringify({ user_input: userInput })
        })
        .then(response => response.json())
        .then(data => {
            naviMessageDiv.innerHTML = `<p>${data.text}</p>`;
        })
        .catch(error => console.error('Error:', error));
    }
});
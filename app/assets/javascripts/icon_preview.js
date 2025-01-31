document.addEventListener("turbolinks:load", function() {
    const iconUpload = document.getElementById("icon-upload-js");
    const iconPreview = document.getElementById("icon-preview-js");

    iconUpload.addEventListener("change", function(event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          iconPreview.src = e.target.result;
          iconPreview.style.display = "block";
        }
        reader.readAsDataURL(file);
      }
    });
});
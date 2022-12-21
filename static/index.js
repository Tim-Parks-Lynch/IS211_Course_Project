if(document.querySelector(".button_alert")){
  alertButton = document.querySelector(".button_alert")
  alertDiv = document.querySelector(".div_alert")
  
  alertButton.addEventListener("click", () => {
    alertDiv.classList.toggle("div_stop_alert")
  })
}

console.log("File Loaded")
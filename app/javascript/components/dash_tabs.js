
const selectTabs = () => {
  const btnResa = document.querySelector("#btn-resa");
  const btnLoc = document.querySelector("#btn-loc");
  const blockLoc = document.querySelector("#block-loc");
  const blockResa = document.querySelector("#block-resa");

  if(blockResa) {
    btnResa.addEventListener("click", (event) => {
      event.preventDefault();
      event.currentTarget.classList.add("active");
      btnLoc.classList.remove("active");
      blockResa.classList.remove("toggle-display");
      blockLoc.classList.add("toggle-display");

    });

    btnLoc.addEventListener("click", (event) => {
      event.preventDefault();
      event.currentTarget.classList.add("active");
      btnResa.classList.remove("active");
      blockLoc.classList.remove("toggle-display")
      blockResa.classList.add("toggle-display");
      ;
    });
  }
}

export {selectTabs};

export default {
  mounted() {
    this.el.addEventListener("click", (event) => {
      event.preventDefault();
      document.querySelector("input#code").select();
      document.execCommand("copy");
    });
  },
};

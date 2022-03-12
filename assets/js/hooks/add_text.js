export default {
  mounted() {
    this.handleEvent("receive_text", ({number}) => {
      console.log(number);
      document.querySelector("input#code").value = number;
    });
  },
};

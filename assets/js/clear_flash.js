const ClearFlash = {
  delay: 5000,

  clearLastFlash() {
    const ids = ["flash-info", "flash-error"];
    const elements = Array.from(this.el.children).filter(el => ids.includes(el.id));
    if (elements.length > 0) {
      const lastFlashElement = elements[elements.length - 1];

      // Remove any existing fade-out animation
      lastFlashElement.classList.remove("animate-fade-out");

      // Force a reflow to restart the animation
      void lastFlashElement.offsetWidth;

      // Add the fade-out class to start the animation
      lastFlashElement.classList.add("animate-fade-out");

      this.timeout = setTimeout(() => {
        this.pushEvent("lv:clear-flash", {key: lastFlashElement.id.replace("flash-", "")});
      }, this.delay);
    }
  },

  mounted() {
    this.clearLastFlash();
  },

  updated() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
    this.clearLastFlash();
  },

  destroyed() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
  }
}

export default ClearFlash;
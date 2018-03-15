/**
 * Sets the value of an input to the current time, formatted as a 24 hour time string.
 * @param {string} selector The query selector of the input element update.
 */
function setCurrentTime(selector) {
    const element = document.querySelector(selector);

    if(element) {
        const current = new Date();
        element.value = `${current.getHours()}:${current.getMinutes()}`
    }
}

function element_exists (id) {
    if (document.getElementById(id)) {
        return true;
    } else {
        return false;
    }
}

module.exports.element_exists = element_exists

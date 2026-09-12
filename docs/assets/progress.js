// Persist Material tasklist checkboxes in localStorage per-page
(function () {
  const key = 'mkdocs-tasks-' + location.pathname;
  function load() {
    try {
      const saved = JSON.parse(localStorage.getItem(key) || '[]');
      const boxes = document.querySelectorAll('input[type="checkbox"]');
      boxes.forEach((b, i) => {
        if (saved[i] !== undefined) b.checked = saved[i];
        b.addEventListener('change', save);
      });
    } catch (e) { /* ignore */ }
  }
  function save() {
    const boxes = document.querySelectorAll('input[type="checkbox"]');
    const vals = Array.from(boxes).map(b => b.checked);
    try { localStorage.setItem(key, JSON.stringify(vals)); } catch (e) {}
  }
  document.addEventListener('DOMContentLoaded', load);
})();

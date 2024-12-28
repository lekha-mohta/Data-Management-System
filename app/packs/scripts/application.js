document.addEventListener("DOMContentLoaded", function() {
  const filterHeader = document.querySelector('.filter-header');
  const arrowIcon = filterHeader.querySelector('.arrow-icon');
  filterHeader.addEventListener('click', function() {
    arrowIcon.querySelector('.arrow-down').classList.toggle('hidden');
    arrowIcon.querySelector('.arrow-up').classList.toggle('hidden');
  });
});


document.addEventListener("DOMContentLoaded", function () {

    const searchInput = document.getElementById("orderSearch");
    const orderRows = document.querySelectorAll("#ordersTable tbody tr");
    const noResults = document.getElementById("noSearchResults");

    if (!searchInput) return;

    searchInput.addEventListener("input", function () {
        const searchValue = searchInput.value.toLowerCase();
        let visibleCount = 0;

        orderRows.forEach(function (row) {
            const matches = row.textContent.toLowerCase()
                .includes(searchValue);

            row.style.display = matches ? "" : "none";

            if (matches) visibleCount++;
        });

        if (noResults) {
            noResults.style.display = visibleCount === 0 ? "block" : "none";
        }
    });

});

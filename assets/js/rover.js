let handleFormSubmit = () => {
    debugger;
    const CSRF_TOKEN = document.querySelector('meta[name="csrf-token"]').content
    fetch("/rover", {
        method: "POST",
        headers: [
            ["Content-Type", "application/json"],
            ["X-CSRF-Token", CSRF_TOKEN]
        ],
        body: JSON.stringify({ direction: "R", steps: "10" })
    });

}
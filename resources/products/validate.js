if (this.title.length < 5) {
    error('title', 'must be at least 5 characters long');
}

if (this.price <= 0) {
    error('price', 'must be greater than zero');
}

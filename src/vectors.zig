pub extern const vector_table: anyopaque;

export fn unhandled() callconv(.c) void {
    while (true) {}
}

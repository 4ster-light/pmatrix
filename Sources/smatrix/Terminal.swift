#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

struct Terminal {
    static func getSize() -> (width: Int, height: Int) {
        #if os(Linux)
            var w = winsize()
            guard ioctl(STDOUT_FILENO, UInt(TIOCGWINSZ), &w) == 0 else {
                return (80, 24)
            }
            return (Int(w.ws_col), Int(w.ws_row))
        #else
            var w = winsize()
            guard ioctl(STDOUT_FILENO, TIOCGWINSZ, &w) == 0 else {
                return (80, 24)
            }
            return (Int(w.ws_col), Int(w.ws_row))
        #endif
    }

    static func setup() {
        print(Config.clearScreen, terminator: "")
        print(Config.hideCursor, terminator: "")
    }

    static func cleanup() {
        print(Config.showCursor, terminator: "")
        print(Config.reset, terminator: "")
    }
}

class Nano < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "https://www.nano-editor.org/"
  url "https://www.nano-editor.org/dist/v2.7/nano-2.7.0.tar.gz"
  mirror "https://ftp.gnu.org/pub/gnu/nano/nano-2.7.0.tar.gz"
  sha256 "5dd1e9cf8e3de676c141a0b23f312e68380ef049926e2913e2114bbe32fbeac3"

  bottle do
    sha256 "afb10d9ad17e5d3689c11b28908f617296c70d5b0e8c511db38d555a0da73ef7" => :el_capitan
    sha256 "a77b0b85d8f3589d3d788fdda5f4cf79a43e6a0e6ce157ad2acebaaf03c96538" => :yosemite
    sha256 "ed0f52e81d8f7a6e56ea8ace29e08aac01b68b7b86ffbd5661ecf4eb804b08a3" => :mavericks
  end

  head do
    url "http://git.savannah.gnu.org/r/nano.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "homebrew/dupes/ncurses"
  depends_on "libmagic" unless OS.mac?

  def install
    # Otherwise SIGWINCH will not be defined
    ENV.append_to_cflags "-U_XOPEN_SOURCE" if MacOS.version < :leopard

    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--enable-utf8"
    system "make", "install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end

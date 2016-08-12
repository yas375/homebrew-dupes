class Lapack < Formula
  desc "Linear Algebra PACKage"
  homepage "http://www.netlib.org/lapack/"
  url "http://www.netlib.org/lapack/lapack-3.6.1.tgz"
  sha256 "888a50d787a9d828074db581c80b2d22bdb91435a673b1bf6cd6eb51aa50d1de"
  head "https://github.com/Reference-LAPACK/lapack.git"

  bottle do
    revision 1
    sha256 "1dbfb0c4eb4c5654e1f5f2712e7a69a764aa6560a1334f363ab8fd0946d4c281" => :el_capitan
    sha256 "03154ac5c8cd043d8d13918488c5ddd960217673659cb4d9d14e0ca78ae2b04f" => :yosemite
    sha256 "678c0f4325b788cd52ff06e51bc4186e8f0a2cd5625a3dfab15ddde648521659" => :mavericks
  end

  keg_only :provided_by_osx

  option "with-doxygen", "Build man pages with Doxygen"

  depends_on "cmake" => :build
  depends_on :fortran
  depends_on "gcc"
  depends_on "doxygen" => [:build, :optional, "with-llvm"]

  def install
    if build.with? "doxygen"
      mv "make.inc.example", "make.inc"
      system "make", "man"
      man3.install Dir["DOCS/man/man3/*"]
    end
    mkdir "build" do
      system "cmake", "..", "-DBUILD_SHARED_LIBS:BOOL=ON", "-DLAPACKE:BOOL=ON",
             *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"lp.cpp").write <<-EOS.undent
      #include "lapacke.h"
      int main() {
        void *p = LAPACKE_malloc(sizeof(char)*100);
        if (p) {
          LAPACKE_free(p);
        }
        return 0;
      }
    EOS
    system ENV.cc, "lp.cpp", "-I#{include}", "-L#{lib}", "-llapacke", "-o", "lp"
    system "./lp"
  end
end

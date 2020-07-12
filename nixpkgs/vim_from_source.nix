# Taken and modified from NixOS/nixpkgs:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/default.nix
{ stdenv, fetchFromGitHub, ncurses, gettext, pkgconfig, darwin }:
stdenv.mkDerivation {
  pname = "vim";
  version = "HEAD";

  src = fetchFromGitHub {
    owner = "vim";
    repo = "vim";
    rev = "HEAD";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [ gettext pkgconfig darwin.apple_sdk.frameworks.AppKit ];
  buildInputs = [ ncurses ];
  configureFlags = [ "--enable-multibyte" "--enable-nls" ]
    ++ stdenv.lib.optionals (stdenv.hostPlatform != stdenv.buildPlatform) [
      "vim_cv_toupper_broken=no"
      "--with-tlib=ncurses"
      "vim_cv_terminfo=yes"
      "vim_cv_tgetent=zero"
      "vim_cv_tty_group=tty"
      "vim_cv_tty_mode=0660"
      "vim_cv_getcwd_broken=no"
      "vim_cv_stat_ignores_slash=yes"
      "ac_cv_sizeof_int=4"
      "vim_cv_memmove_handles_overlap=yes"
    ];

  postPatch = ''
    substituteInPlace runtime/ftplugin/man.vim --replace "/usr/bin/man " "man "
  '';

  postInstall = ''
    ln -s $out/bin/vim $out/bin/vi
    mkdir -p $out/share/vim
  '';

  meta = {
    description = "The most popular clone of the VI editor";
    homepage = "http://www.vim.org";
    license = stdenv.lib.licenses.vim;
    platforms = stdenv.lib.platforms.unix;
  };
}

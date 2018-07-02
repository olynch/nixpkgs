{ stdenv, fetchFromGitHub, ncurses, mesa_glu, freeglut, libzip, 
   ocaml, findlib, ocamlbuild,
   earley, earley_ocaml, imagelib,
   ocaml_sqlite3, camlzip, 
   lablgtk, ocaml_cairo,
   lablgl, ocamlnet, cryptokit,
   ocaml_pcre }:

let
  ocaml_version = (builtins.parseDrvName ocaml.name).version;
in

stdenv.mkDerivation {
  name = "patoline-unstable";

  src = fetchFromGitHub {
    owner = "patoline";
    repo = "patoline";
    rev = "553659ee314abfffdc717d3e19965952ec2cfd0d";
    sha256 = "0vv82q2z1mbzkp9wnnlcgssfgchnd0inhnwrpy25dpni742mp7h6";
  };

  # createFindlibDestdir = true;
   
  buildInputs = [ ocaml ocamlbuild findlib ocaml_sqlite3 camlzip 
   lablgtk ocaml_cairo
   earley earley_ocaml imagelib
   lablgl ocamlnet cryptokit
   ocaml_pcre ncurses mesa_glu freeglut libzip ];

  propagatedbuildInputs = [ 
   ocaml_sqlite3 camlzip 
   earley earley_ocaml imagelib
   lablgtk ocaml_cairo ocamlbuild
   lablgl ocamlnet cryptokit
   ocaml_pcre ncurses mesa_glu freeglut libzip ];

  buildPhase = ''
    make configure
    ./configure \
       --prefix $out
    make
    make packages
  '';

  preInstall = ''
    mkdir -p $out/lib/ocaml/${ocaml_version}/site-lib
    mkdir -p $out/lib/ocaml/rawlib
  '';

  
  meta = {
    homepage = http://patoline.org;
    description = "Patoline ocaml based typesetting system";
  };
}

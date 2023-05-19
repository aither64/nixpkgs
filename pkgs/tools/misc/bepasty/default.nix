{ python3
, lib
, fetchFromGitHub
, git
}:
#We need to use buildPythonPackage here to get the PYTHONPATH build correctly.
#This is needed for services.bepasty
#https://github.com/NixOS/nixpkgs/pull/38300
with python3.pkgs; buildPythonPackage rec {
  pname = "bepasty";
  version = "1.1.0";

  propagatedBuildInputs = [
    flask
    pygments
    setuptools
    xstatic
    xstatic-asciinema-player
    xstatic-bootbox
    xstatic-bootstrap
    xstatic-font-awesome
    xstatic-jquery
    xstatic-jquery-file-upload
    xstatic-jquery-ui
    xstatic-pygments
  ];

  nativeBuildInputs = [ git ];
  buildInputs = [ setuptools-scm ];

  src = fetchFromGitHub {
    owner = "aither64";
    repo = "bepasty-server";
    rev = "d09478b1d5a6c959844faec02595f16efc5bbe07";
    sha256 = "sha256-787vFJn22oTWcqsXMiEGasf90Bt+VmKlBjoO70jr9X0=";
    leaveDotGit = true;
  };

  nativeCheckInputs = [
    pytest
    selenium
  ];

  # No tests in sdist
  doCheck = false;

  meta = {
    homepage = "https://github.com/bepasty/bepasty-server";
    description = "Binary pastebin server";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ aither64 makefu ];
  };
}

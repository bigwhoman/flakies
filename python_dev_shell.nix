with import <nixpkgs> { config.allowUnfree = true;};

let
  pythonPackages = python312Packages; # Change to Python 3.10
in pkgs.mkShell rec {
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.cudatoolkit}/lib:/run/opengl-driver/lib
    export CUDA_HOME=${pkgs.cudaPackages.cudatoolkit}
  ''; 
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [

    pkgs.stdenv.cc.cc.lib

    git-crypt
    # stdenv.cc.cc # jupyter lab needs

    # pythonPackages.python
    pythonPackages.ipykernel
    pythonPackages.jupyterlab
    pythonPackages.pyzmq    # Adding pyzmq explicitly
    pythonPackages.venvShellHook
    pythonPackages.pip
    pythonPackages.numpy
    pythonPackages.pandas
    pythonPackages.torch-bin
    pythonPackages.torchvision-bin
    pythonPackages.requests
    pythonPackages.matplotlib

    pkgs.cudaPackages.cudatoolkit
    # sometimes you might need something additional like the following - you will get some useful error if it is looking for a binary in the environment.
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    libstdcxx5
    zlib

  ];

  # Run this command, only after creating the virtual environment
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    
    python -m ipykernel install --user --name=myenv4 --display-name="myenv4"
    pip install -r requirements.txt
  '';

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH
  '';
}

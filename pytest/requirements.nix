# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -v -V 3.5 -O ../overrides.nix -r requirements.txt
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python35;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            sed -i \
              -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
              -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python35-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "Mako" = python.mkDerivation {
      name = "Mako-1.0.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/eb/f3/67579bb486517c0d49547f9697e36582cd19dafb5df9e687ed8e22de57fa/Mako-1.0.7.tar.gz"; sha256 = "4e02fde57bd4abb5ec400181e4c314f56ac3e49ba4fb8b0d50bba18cb27d25ae"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."MarkupSafe"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.makotemplates.org/";
        license = licenses.mit;
        description = "A super-fast templating language that borrows the  best ideas from the existing templating languages.";
      };
    };

    "MarkupSafe" = python.mkDerivation {
      name = "MarkupSafe-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"; sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/pallets/markupsafe";
        license = licenses.bsdOriginal;
        description = "Implements a XML/HTML/XHTML Markup safe string for Python";
      };
    };

    "apipkg" = python.mkDerivation {
      name = "apipkg-1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/32/37/6ce6dbaa8035730efa95e60b09498ec17000d137742391ff46974d9ef859/apipkg-1.4.tar.gz"; sha256 = "2e38399dbe842891fe85392601aab8f40a8f4cc5a9053c326de35a1cc0297ac6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/hpk42/apipkg";
        license = licenses.mit;
        description = "apipkg: namespace control and lazy-import mechanism";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-17.3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/3f/a4/d0db68156abbdee228ce69a786ecb512da40b36b1289aadb9e3f9fd45121/attrs-17.3.0.tar.gz"; sha256 = "c78f53e32d7cf36d8597c8a2c7e3c0ad210f97b9509e152e4c37fa80869f823c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "coverage" = python.mkDerivation {
      name = "coverage-4.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0b/e1/190ef1a264144c9b073b7353c259ca5431b5ddc8861b452e858fcbd0e9de/coverage-4.4.2.tar.gz"; sha256 = "309d91bd7a35063ec7a0e4d75645488bfab3f0b66373e7722f23da7f5b0f34cc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/ned/coveragepy";
        license = licenses.asl20;
        description = "Code coverage measurement for Python";
      };
    };

    "decorator" = python.mkDerivation {
      name = "decorator-4.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bb/e0/f6e41e9091e130bf16d4437dabbac3993908e4d6485ecbc985ef1352db94/decorator-4.1.2.tar.gz"; sha256 = "7cb64d38cb8002971710c8899fbdfb859a23a364b7c99dab19d1f719c2ba16b5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/micheles/decorator";
        license = licenses.bsdOriginal;
        description = "Better living through Python with decorators";
      };
    };

    "execnet" = python.mkDerivation {
      name = "execnet-1.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ab/c0/9496c35092eac2523ee8993ca3690b2d0aa95ef56623035b9c890745ac55/execnet-1.5.0.tar.gz"; sha256 = "a7a84d5fa07a089186a329528f127c9d73b9de57f1a1131b82bb5320ee651f6a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."apipkg"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://codespeak.net/execnet";
        license = licenses.mit;
        description = "execnet: rapid multi-Python deployment";
      };
    };

    "glob2" = python.mkDerivation {
      name = "glob2-0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f0/e8/970c7a031b2d7f9a21fefaa8c9d5c38001f8f25055f4ffcb32b3dbecd1ea/glob2-0.6.tar.gz"; sha256 = "f5b0a686ff21f820c4d3f0c4edd216704cea59d79d00fa337e244a2f2ff83ed6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/miracle2k/python-glob2/";
        license = licenses.bsdOriginal;
        description = "Version of the glob module that can capture patterns and supports recursive wildcards";
      };
    };

    "greenlet" = python.mkDerivation {
      name = "greenlet-0.4.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/be/76/82af375d98724054b7e273b5d9369346937324f9bcc20980b45b068ef0b0/greenlet-0.4.12.tar.gz"; sha256 = "e4c99c6010a5d153d481fdaf63b8a0782825c0721506d880403a3b9b82ae347e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/python-greenlet/greenlet";
        license = licenses.mit;
        description = "Lightweight in-process concurrent programming";
      };
    };

    "oejskit" = python.mkDerivation {
      name = "oejskit-0.9.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/10/f9d24c1f5ff7a8236e48d3c8fbd12e76eb4741e6f4e76e5c25c51d7ed7a9/oejskit-0.9.0.tar.gz"; sha256 = "06d645e2506acd85b8a858b550907c5c8440d4f1315fc2c4e6b86b091c29846e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/pedronis/js-infrastructure/";
        license = licenses.mit;
        description = "Open End JavaScript testing and utility kit";
      };
    };

    "parse" = python.mkDerivation {
      name = "parse-1.8.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/13/71/e0b5c968c552f75a938db18e88a4e64d97dc212907b4aca0ff71293b4c80/parse-1.8.2.tar.gz"; sha256 = "8048dde3f5ca07ad7ac7350460952d83b63eaacecdac1b37f45fd74870d849d2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/r1chardj0n3s/parse";
        license = licenses.bsdOriginal;
        description = "parse() is the opposite of format()";
      };
    };

    "parse-type" = python.mkDerivation {
      name = "parse-type-0.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2b/e5/312ce9f1bd209afcf4fc68235c8776a36270d24ad05bdfd2aaaf06647ea9/parse_type-0.4.2.tar.gz"; sha256 = "f596bdc75d3dd93036fbfe3d04127da9f6df0c26c36e01e76da85adef4336b3c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."parse"
      self."pytest"
      self."pytest-cov"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jenisys/parse_type";
        license = licenses.bsdOriginal;
        description = "Simplifies to build parse types based on the parse module";
      };
    };

    "pep8" = python.mkDerivation {
      name = "pep8-1.7.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/01/a0/64ba19519db49e4094d82599412a9660dee8c26a7addbbb1bf17927ceefe/pep8-1.7.1.tar.gz"; sha256 = "fe249b52e20498e59e0b5c5256aa52ee99fc295b26ec9eaa85776ffdb9fe6374"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pep8.readthedocs.org/";
        license = licenses.mit;
        description = "Python style guide checker";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz"; sha256 = "7f8ae7f5bdf75671a718d2daf0a64b7885f74510bcd98b1a0bb420eb9a9d0cff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.5.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/90/e3/e075127d39d35f09a500ebb4a90afd10f9ef0a1d28a6d09abeec0e444fdd/py-1.5.2.tar.gz"; sha256 = "ca18943e28235417756316bfada6cd96b23ce60dd532642690dcfdaba988a76d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pyflakes" = python.mkDerivation {
      name = "pyflakes-1.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/26/85/f6a315cd3c1aa597fb3a04cc7d7dbea5b3cc66ea6bd13dfa0478bf4876e6/pyflakes-1.6.0.tar.gz"; sha256 = "8d616a382f243dbf19b54743f280b80198be0bca3a5396f1d2e1fca6223e8805"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/PyCQA/pyflakes";
        license = licenses.mit;
        description = "passive checker of Python programs";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-3.3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fb/ee/ceb80b45e768e67ee848dfd4fc407a4ccfc6d93c904c49fad1e5495a079f/pytest-3.3.1.tar.gz"; sha256 = "cf8436dc59d8695346fcd3ab296de46425ecab00d64096cebe79fb51ecb2eb93"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."attrs"
      self."pluggy"
      self."py"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pytest.org";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytest-bdd" = python.mkDerivation {
      name = "pytest-bdd-2.19.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f7/9c/a71a6f8b4641552add19e71ec24df2b1b88ff147ff8c0ca9949433e557c5/pytest-bdd-2.19.0.tar.gz"; sha256 = "d1e5a629b996555c020c076e503b596437ba8536165acc9c7c95fb5de4c19c93"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Mako"
      self."glob2"
      self."parse"
      self."parse-type"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-bdd";
        license = licenses.mit;
        description = "BDD for pytest";
      };
    };

    "pytest-cache" = python.mkDerivation {
      name = "pytest-cache-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d1/15/082fd0428aab33d2bafa014f3beb241830427ba803a8912a5aaeaf3a5663/pytest-cache-1.0.tar.gz"; sha256 = "be7468edd4d3d83f1e844959fd6e3fd28e77a481440a7118d430130ea31b07a9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."execnet"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/hpk42/pytest-cache/";
        license = licenses.gpl1;
        description = "pytest plugin with mechanisms for caching across test runs";
      };
    };

    "pytest-catchlog" = python.mkDerivation {
      name = "pytest-catchlog-1.2.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f2/2b/2faccdb1a978fab9dd0bf31cca9f6847fbe9184a0bdcc3011ac41dd44191/pytest-catchlog-1.2.2.zip"; sha256 = "4be15dc5ac1750f83960897f591453040dff044b5966fe24a91c2f7d04ecfcf0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."py"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eisensheng/pytest-catchlog";
        license = licenses.mit;
        description = "py.test plugin to catch log messages. This is a fork of pytest-capturelog.";
      };
    };

    "pytest-cov" = python.mkDerivation {
      name = "pytest-cov-2.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/24/b4/7290d65b2f3633db51393bdf8ae66309b37620bc3ec116c5e357e3e37238/pytest-cov-2.5.1.tar.gz"; sha256 = "03aa752cf11db41d281ea1d807d954c4eda35cfa1b21d6971966cc041bbf6e2d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."coverage"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-cov";
        license = licenses.bsdOriginal;
        description = "Pytest plugin for measuring coverage.";
      };
    };

    "pytest-django" = python.mkDerivation {
      name = "pytest-django-3.1.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/78/8b/aeab19b727411f3ec5f68dc8c05b2dba949b27ed592d68217e72e7d4ce65/pytest-django-3.1.2.tar.gz"; sha256 = "038ccc5a9daa1b1b0eb739ab7dce54e495811eca5ea3af4815a2a3ac45152309"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pytest-django.readthedocs.io/";
        license = licenses.bsdOriginal;
        description = "A Django plugin for pytest.";
      };
    };

    "pytest-flakes" = python.mkDerivation {
      name = "pytest-flakes-2.0.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4f/02/0450e82e3d1a8e973fd695fff99122491a977c06357e32006ac9e281a5a2/pytest-flakes-2.0.0.tar.gz"; sha256 = "3e880927fd2a77d31715eaab3876196e76d779726c9c24fe32ee5bab23281f82"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyflakes"
      self."pytest"
      self."pytest-cache"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/fschulze/pytest-flakes";
        license = licenses.mit;
        description = "pytest plugin to check source code with pyflakes";
      };
    };

    "pytest-forked" = python.mkDerivation {
      name = "pytest-forked-0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b3/b2/1ec910b0f798cc86f2531631d7a2da030b16c165e07545537332fd4eb505/pytest-forked-0.2.tar.gz"; sha256 = "e4500cd0509ec4a26535f7d4112a8cc0f17d3a41c29ffd4eab479d2a55b30805"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-forked";
        license = licenses.mit;
        description = "run tests in isolated forked subprocesses";
      };
    };

    "pytest-instafail" = python.mkDerivation {
      name = "pytest-instafail-0.3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/11/d0/371d9e86e823c775e9f23ad797d7738b1afa94223ac82c20b5bdc735ea1d/pytest-instafail-0.3.0.tar.gz"; sha256 = "b4d5fc3ca81e530a8d0e15a7771dc14b06fc9a0930c4b3909a7f4527040572c3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jpvanhal/pytest-instafail";
        license = licenses.bsdOriginal;
        description = "py.test plugin to show failures instantly";
      };
    };

    "pytest-pep8" = python.mkDerivation {
      name = "pytest-pep8-1.0.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1f/1c/c834344ef39381558b047bea1e3005197fa8457c199d58219996ca07defb/pytest-pep8-1.0.6.tar.gz"; sha256 = "032ef7e5fa3ac30f4458c73e05bb67b0f036a8a5cb418a534b3170f89f120318"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pep8"
      self."pytest"
      self."pytest-cache"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/hpk42/pytest-pep8/";
        license = "MIT license";
        description = "pytest plugin to check PEP8 requirements";
      };
    };

    "pytest-timeout" = python.mkDerivation {
      name = "pytest-timeout-1.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/be/e9/a9106b8bc87521c6813060f50f7d1fdc15665bc1bbbe71c0ffc1c571aaa2/pytest-timeout-1.2.1.tar.gz"; sha256 = "68b7d264633d5d33ee6b14ce3a7f7d05f8fd9d2f6ae594283221ec021736b7cd"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/pytest-dev/pytest-timeout/";
        license = licenses.mit;
        description = "py.test plugin to abort hanging tests";
      };
    };

    "pytest-twisted" = python.mkDerivation {
      name = "pytest-twisted-1.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/74/66/0c64463ed9501c09e4c79bc924743e2e4cd02eb4498d492b5e3c81911198/pytest-twisted-1.5.zip"; sha256 = "d0dc887f15f4d0ade882e56590a3cce95b70fd0687ba8d2428a6364f3288d87e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."decorator"
      self."greenlet"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/schmir/pytest-twisted";
        license = licenses.bsdOriginal;
        description = "A twisted plugin for py.test.";
      };
    };

    "pytest-xdist" = python.mkDerivation {
      name = "pytest-xdist-1.21.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/57/26/4cde9e52098487da0330dfbe49ccc107108b4c86a22aee6a7640d6cdf51a/pytest-xdist-1.21.0.tar.gz"; sha256 = "0b8622435e3c0650a8d5a07b73a7f9c4f79b52d7ed060536a6041f0da423ba8e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."execnet"
      self."pytest"
      self."pytest-forked"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-xdist";
        license = licenses.mit;
        description = "py.test xdist plugin for distributed testing and loop-on-failing modes";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (import ../overrides.nix { inherit pkgs python ; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )
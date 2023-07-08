{ stdenv
, php
, fetchFromGitHub
, lib
, libiconv
, pcre2
, pkg-config
, cyrus_sasl
, icu64
, openssl
, snappy
, zlib
, Security
, Libsystem
}:

php.buildPecl rec {
  pname = "mongodb";
  version = "1.16.1";

  src = fetchFromGitHub {
    owner = "mongodb";
    repo = "mongo-php-driver";
    rev = version;
    hash = "sha256-nVkue3qB6OwXKcyaYU1WmXG7pamKQtk8cbztVVkNejo=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    cyrus_sasl
    icu64
    openssl
    snappy
    zlib
    pcre2
  ] ++ lib.optionals stdenv.isDarwin [
    Security
    Libsystem
    libiconv
  ];

  meta = {
    description = "The Official MongoDB PHP driver";
    homepage = "https://github.com/mongodb/mongo-php-driver";
    license = lib.licenses.asl20;
    maintainers = lib.teams.php.members;
  };
}

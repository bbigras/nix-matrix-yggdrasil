{ ... }:

let
  nix-matrix-yggdrasil = (import ./default.nix).main;
in
{
  name = "nix-matrix-yggdrasil-test";
  nodes.server = { ... }: {

    systemd.services.matrix-yggdrasil = {
      description = "matrix-yggdrasil";
      serviceConfig = {
        ExecStart = "${nix-matrix-yggdrasil}/bin/dendrite-demo-yggdrasil";
      };
      wantedBy = [ "default.target" ];
    };
  };

  testScript = ''
    start_all()
    server.wait_for_unit("matrix-yggdrasil.service")
  '';
}

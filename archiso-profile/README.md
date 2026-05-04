# Gerador de ISO (Archiso) para o Minecraft

Com essas configuracoes, voce pode construir sua propria ISO Bootavel que ja contem dependencias base pre-instaladas. Isso economiza tempo porque toda a base do sistema e dependencias (Java 21, Tailscale, NetworkManager) ja estarao embutidas e prontas na hora do Boot.

### Como Construir a Imagem .iso

1. **Rodando a partir de um Arch Linux Hospedeiro**, instale a ferramenta de construção:
```bash
sudo pacman -S archiso
```

2. **Copie o perfil original** `releng` para servir de esqueleto:
```bash
cp -r /usr/share/archiso/configs/releng ~/archiso-minecraft
```

3. **Substitua os arquivos** pelos da pasta `archiso-profile`:
   * Adicione o `packages.x86_64` modificado para conter os nossos pacotes listados.
   * Adicione o `profiledef.sh` para mudar o nome e título da ISO.
   * O script automatico do live fica em `airootfs/root/.automated_script.sh` e pode ser executado no boot.

4. **Inicie o gerador (`mkarchiso`)**:
```bash
sudo mkarchiso -v -w /tmp/archiso-tmp -o ~/out ~/archiso-minecraft
```

Ao final desse processo (que pode demorar um pouco e exigir alguns GBs livres em disco e RAM), ele vai gerar o arquivo da ISO dentro da pasta `~/out`. Você pode flashear essa ISO em um Pendrive pelo BalenaEtcher ou Rufus.

Depois, na maquina alvo, basta plugar o pendrive e dar Boot. Ao cair no console do Live USB, voce pode rodar `/root/.automated_script.sh` para clonar o repo e iniciar o instalador.

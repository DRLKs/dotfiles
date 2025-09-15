# dotfiles
dotfiles of my OS

# Gestor de arranque GDM
El gestor de arranque que he usado es Gnome Display Manager.
- El primer paso para poder hacer uso de este gestor de arranque es instalarlo y luego activarlo para que se inicie al arrancar.
```bash
sudo pacman -S gdm
sudo systemctl enable gdm
```
- En caso de que falle, probablemente se deba a que no tienes el gestor de arranque en versión gráfica.
Cambialo asi:
```bash
sudo systemctl set-default graphical.target
```

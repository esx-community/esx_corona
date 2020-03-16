# esx_corona
COVID19 now in FiveM
- Contaminate a player randomly
- Cough / Sneeze animation with synced FX
- If other players are nearby when you cough, they will be infected
- Wearing a mask protects you
- A vaccine is usable (add the item in db)
- Random ragdoll
- Some settings available

## Requirements

- [es_extended](https://github.com/ESX-Org/es_extended)
- [skinchanger](https://github.com/ESX-Org/skinchanger)

## Download & Installation

### Using [fvm](https://github.com/qlaffont/fvm-installer)
```
fvm install --save --folder=esx esx-public/esx_corona
```

### Using Git
```
cd resources
git clone https://github.com/ESX-PUBLIC/esx_corona [esx]/esx_corona
```

### Manually
- Download https://github.com/ESX-PUBLIC/esx_corona/archive/master.zip
- Put it in the `[esx]` directory

## Installation
- Add this to your `server.cfg`:

```
ensure esx_corona
```
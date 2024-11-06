resource "azurerm_resource_group" "rg-b" {
  name     = "priyanshi"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet-b" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-b.location
  resource_group_name = azurerm_resource_group.rg-b.name
}

resource "azurerm_subnet" "subnet-b" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg-b.name
  virtual_network_name = azurerm_virtual_network.vnet-b.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic-b" {
  name                = "nic"
  location            = azurerm_resource_group.rg-b.location
  resource_group_name = azurerm_resource_group.rg-b.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-b.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-b.id
  }
}
resource "azurerm_public_ip" "pip-b" {
  name                = "pip1"
  resource_group_name = azurerm_resource_group.rg-b.name
  location            = azurerm_resource_group.rg-b.location
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "vm-b" {
  name                = "priyanshi-machine"
  resource_group_name = azurerm_resource_group.rg-b.name
  location            = azurerm_resource_group.rg-b.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Priyanshi@2721"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic-b.id]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
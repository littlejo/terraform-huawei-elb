#TODO
# Improve eip billing

resource "huaweicloud_lb_loadbalancer" "this" {
  name          = var.name
  vip_subnet_id = var.vip_subnet_id
}

resource "huaweicloud_vpc_eip" "this" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "elb"
    size        = 8
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

resource "huaweicloud_networking_eip_associate" "eip_1" {
  public_ip = huaweicloud_vpc_eip.this.address
  port_id   = huaweicloud_lb_loadbalancer.this.vip_port_id
}


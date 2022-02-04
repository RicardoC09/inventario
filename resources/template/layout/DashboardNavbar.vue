<template>
  <div>
    <base-nav
      class="navbar-top navbar-dark"
      id="navbar-main"
      :show-toggle-button="false"
      expand
    >
    <!-- Segundo Header -->
      <form
        class="navbar-search navbar-search-dark form-inline mr-3 d-none d-md-flex ml-lg-auto"
      >
        <!--<div class="form-group mb-0">
          <base-input
            placeholder="Search"
            class="input-group-alternative"
            alternative=""
            addon-right-icon="fas fa-search"
          >
          </base-input>
        </div>-->
      </form>
      <ul class="navbar-nav align-items-center d-none d-md-flex">
        <li class="nav-item dropdown">
          <base-dropdown class="nav-link pr-0">
            <div class="media align-items-center" slot="title">
              <span class="avatar avatar-sm rounded-circle">
                <img alt="Image placeholder" src="../assets/img/foto.png" />
              </span>
              <div class="media-body ml-2 d-none d-lg-block">
                <span class="mb-0 text-sm font-weight-bold texto-nombre"
                  >Jorge Cutiva</span
                >
              </div>
            </div>
            <!-- Barra Header -->
            <template>
              <div class="dropdown-header noti-title">
                <h6 class="text-overflow m-0">Bienvenido</h6>
              </div>
              <router-link to="/profile" class="dropdown-item">
                <i class="ni ni-settings-gear-65"></i>
                <span>Configuración</span>
              </router-link>
              <router-link to="/profile" class="dropdown-item">
                <i class="ni ni-single-02"></i>
                <span>Cambiar Imagen</span>
              </router-link>
              <!-- <router-link to="/profile" class="dropdown-item">
                <i class="ni ni-calendar-grid-58"></i>
                <span>Activity</span>
              </router-link>-->
              <!--<router-link to="/profile" class="dropdown-item">
                <i class="ni ni-support-16"></i>
                <span>Support</span>
              </router-link>-->
              <div class="dropdown-divider"></div>
              <router-link to="/profile" class="dropdown-item">
                <i class="ni ni-user-run"></i>
                <span>Cerrar Sesión</span>
              </router-link>
            </template>
          </base-dropdown>
        </li>
      </ul>
    </base-nav>
    <div>
      <!-- Segundo Header -->
      <nav class="navbar-medio">
        <p class="text-titulo text-uppercase">{{ $route.name }}</p>
      </nav>
    </div>
    <div>
      <!-- Tercero Header -->
      <!--<nav class="navbar-final">
        <div class="contenedor-buscar">
        <form
          class="navbar-search"
        >
          <div class="form-group mb-0">
            <base-input
              placeholder="Search"
              class="input-group-alternative"
              alternative=""
              addon-right-icon="ni ni-ui-04"
            >
            </base-input>
          </div>
        </form>
        </div>
      </nav>-->
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      activeNotifications: false,
      showMenu: false,
      searchQuery: "",
    };
  },
  methods: {
    toggleSidebar() {
      this.$sidebar.displaySidebar(!this.$sidebar.showSidebar);
    },
    hideSidebar() {
      this.$sidebar.displaySidebar(false);
    },
    toggleMenu() {
      this.showMenu = !this.showMenu;
    },
  },
};
</script>
<style scoped>
.text-titulo {
  position: relative;
  text-align: center;
  color: #8f141b;
  font-weight: bolder;
  font-size: x-large;
  top: 11px;
}

.texto-nombre{
  color:#DFD4A6;
}
.contenedor-buscar{
  position: relative;
  top:11px;
}

.form-group{
    left:25%; 
}
.input-group-text{
  text-align: right;
}

</style>

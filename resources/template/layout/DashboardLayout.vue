<template>
  <div class="wrapper" :class="{ 'nav-open': $sidebar.showSidebar }">
    <side-bar
      :background-color="sidebarBackground"
      short-title="Inicio"
      title="Inicio"
    >
      <template slot="links">
        <sidebar-item
          :link="{
            name: 'Inicio',
            icon: 'ni ni-shop text-primary',
            path: '/inicio',
          }"
        />
        <sidebar-item
          :link="{
            name: 'Inventarios',
            icon: 'ni ni-folder-17 text-yellow',
            path: '/inventario',
          }"
        />
        <sidebar-item
          :link="{
            name: 'Roles',
            icon: 'ni ni-single-copy-04 text-blue',
            path: '/rol',
          }"
        />
        <sidebar-item
          :link="{
            name: 'Usuarios',
            icon: '',
            path: '/usuarios',
          }"
        />
        <sidebar-item
          :link="{
            name: 'Nuevo Expediente',
            icon: 'ni ni-fat-add text-green',
            path: '/tables',
          }"
        />
        <sidebar-item
          :link="{
            name: 'Reportes',
            icon: 'ni ni-ruler-pencil text-orange',
            path: '/tables',
          }"
        />
        
        <sidebar-item
          :link="{
            name: 'Cerrar Sesion',
            icon: 'ni ni-user-run text-red',
            path: '/LoginV2',
          }"
        />
         <!-- <sidebar-item
                    :link="{
                      name: 'Dashboards',
                      icon: 'ni ni-shop text-primary',
                    }"
                  >
            <sidebar-item
              :link="{ name: 'Dashboard', path: '/menuExpediente', }"
            ></sidebar-item>
            <sidebar-item
              :link="{ name: 'Alternative', path: '/alternative', }"
            ></sidebar-item>
          </sidebar-item> -->    
        <!-- your content here 
        <sidebar-item :link="{name: 'Login', icon: 'ni ni-key-25 text-info', path: '/login'}"/>
        <sidebar-item :link="{name: 'Register', icon: 'ni ni-circle-08 text-pink', path: '/register'}"/>-->
      </template>
    </side-bar>
    <div class="main-content" :data="sidebarBackground">
      <dashboard-navbar />

      <div @click="toggleSidebar">
        <fade-transition :duration="200" origin="center top" mode="out-in">
          <!-- your content here -->
          <router-view />
        </fade-transition>
        <content-footer v-if="!$route.meta.hideFooter" />
      </div>
    </div>
  </div>
</template>
<script>
import DashboardNavbar from "./DashboardNavbar.vue";
/*import ContentFooter from './ContentFooter.vue';*/
import { FadeTransition } from "vue2-transitions";

export default {
  components: {
    DashboardNavbar,
    /*ContentFooter,*/
    FadeTransition,
  },
  data() {
    return {
      sidebarBackground: "vue", //vue|blue|orange|green|red|primary
    };
  },
  methods: {
    toggleSidebar() {
      if (this.$sidebar.showSidebar) {
        this.$sidebar.displaySidebar(false);
      }
    },
  },
};
</script>
<style lang="scss">
</style>

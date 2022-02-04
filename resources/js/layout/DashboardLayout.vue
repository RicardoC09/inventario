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
            name: 'Dashboard',
            icon: 'ni ni-shop text-primary',
            path: '/dashboard',
          }"
                />
                <b-dropdown text="Inventario" class="m-2">
                <b-dropdown-item>
                    <sidebar-item :link="{
                        name: 'Inventariossssssss',
                        icon: 'ni ni-fat-add text-green',
                        path: '/inventario',
                        }"
                    />
                    <sidebar-item
                        :link="{
                                    name: 'Menu Documentosssssss',
                                    icon: 'ni ni-folder-17 text-yellow',
                                    path: '/MenuDocumentos',
                                }"
                    />
                </b-dropdown-item>
                </b-dropdown>

                <b-dropdown text="Menu Documentosssssssssss" class="m-2">
                    <b-dropdown-item>
                        <sidebar-item
                            :link="{
                                    name: 'Crear Expediente',
                                    icon: 'ni ni-fat-add text-green',
                                    path: '/crearExpediente',
                                  }"
                        />
                        <sidebar-item
                            :link="{
                                    name: 'Crear Subexpediente',
                                    icon: 'ni ni-fat-add text-green',
                                    path: '/CrearSubexpediente',
                                  }"
                        />
                        <sidebar-item
                            :link="{
                                    name: 'Crear Documento',
                                    icon: 'ni ni-fat-add text-green',
                                    path: '/CrearDocumento',
                                  }"
                        />
                    </b-dropdown-item>
                </b-dropdown>

                <b-dropdown text="Usuarios" class="m-2">
                    <b-dropdown-item>
                        <sidebar-item
                            :link="{
                                    name: 'Crear Persona',
                                    icon: 'ni ni-fat-add text-green',
                                    path: '/crearPersona',
                                  }"
                        />
                        <sidebar-item
                            :link="{
                                        name: 'Usuarios',
                                        icon: 'ni ni-single-02 text-red',
                                        path: '/usuarios',
                                     }"
                        />
                        <sidebar-item
                            :link="{
                                    name: 'Roles',
                                    icon: 'ni ni-single-copy-04 text-blue',
                                    path: '/rol',
                                  }"
                        />
                    </b-dropdown-item>
                </b-dropdown>

                <b-dropdown text="Reportes" class="m-2">
                    <b-dropdown-item>
                        <sidebar-item
                            :link="{
                                        name: 'Reporte por Expediente',
                                        icon: 'ni ni-ruler-pencil text-green',
                                        path: '/ReporteDocumentalPorExpediente',
                            }"
                        />
                        <sidebar-item
                            :link="{
                                        name: 'Reporte Por Documento',
                                        icon: 'ni ni-ruler-pencil text-orange',
                                        path: '/ReporteDocumentalPorDocumento',
                            }"
                        />
                    </b-dropdown-item>
                </b-dropdown>
                <sidebar-item
                    :link="{
                            name: 'Cerrar Sesion',
                            icon: 'ni ni-user-run text-red',
                            path: '/LoginV2',
                    }"
                />

            </template>
        </side-bar>
        <div class="main-content" :data="sidebarBackground">
            <dashboard-navbar/>
            <div @click="toggleSidebar">
                <fade-transition :duration="200" origin="center top" mode="out-in">
                    <!-- your content here -->
                    <router-view/>
                </fade-transition>
            </div>
        </div>
    </div>

</template>
<script>
    import DashboardNavbar from "./DashboardNavbar.vue";
    /*import ContentFooter from './ContentFooter.vue';*/
    import {FadeTransition} from "vue2-transitions";

    export default {
        name: 'DashboardLayout',
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

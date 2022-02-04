<template>
    <div>
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
                        path: '/home',
                      }"
                    />
                    <b-dropdown text="Inventario" class="m-2">
                        <b-dropdown-item>
                            <sidebar-item :link="{
                        name: 'Inventario',
                        icon: 'ni ni-fat-add text-green',
                        path: '/inventario',
                        }"
                        
                            />
                               <sidebar-item :link="{
                        name: 'Crear Seccion',
                        icon: 'ni ni-fat-add text-green',
                        path: '/CrearSeccion',
                        }"
                        
                            />
                                  <sidebar-item :link="{
                        name: 'Crear Subseccion',
                        icon: 'ni ni-fat-add text-green',
                        path: '/CrearSubSeccion',
                        }"
                        
                            />
                          <sidebar-item :link="{
                        name: 'Crear Serie',
                        icon: 'ni ni-fat-add text-green',
                        path: '/CrearSeries',
                        }"
                        
                            />
                            <sidebar-item :link="{
                        name: 'Crear SubSeries',
                        icon: 'ni ni-fat-add text-green',
                        path: '/CrearSubSeries',
                        }"
                        
                            />
                        </b-dropdown-item>
                    </b-dropdown>

                    <b-dropdown text="Menu Documentos" class="m-2">
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

                    <!-- <b-dropdown text="Reportes" class="m-2">
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
                    </b-dropdown>-->
                    <!--<sidebar-item 
                        :link="{
                            name: 'Cerrar Sesion',
                            icon: 'ni ni-user-run text-red',
                            path: '/Logout',
                    }"
                    />-->
                    <button @click="logOut()">CERRAR SESION</button>
                    <!-- <router-link to="/login" @click="logOut()" class="dropdown-item">
                        <i class="ni ni-user-run"></i>
                        <span>Cerrar Sesión</span>
                    </router-link> -->

                </template>
            </side-bar>
            <div class="main-content" :data="sidebarBackground">
                <dashboard-navbar/>
                <div @click="toggleSidebar">
                    <fade-transition :duration="200" origin="center top" mode="out-in">
                        <!-- your content here -->
                        <router-view></router-view>
                    </fade-transition>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import DashboardNavbar from "./layout/DashboardNavbar";
    import {FadeTransition} from "vue2-transitions";
    import axios from 'axios';
    
    export default {
        name: "App",
        components: {
            DashboardNavbar,
            FadeTransition,
        },
        data() {
            return {
                sidebarBackground: "vue",
            };
        },
        methods: {
            toggleSidebar() {
                if (this.$sidebar.showSidebar) {
                    this.$sidebar.displaySidebar(false);
                }
            },
            logOut: function (){
                window.location.replace('/Logout');
            }

        },
    }
</script>

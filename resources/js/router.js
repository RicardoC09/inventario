import Vue from 'vue'
import Router from 'vue-router'
import Content from './layout/Content'
import Home from './components/Home'
import CrearSeries from './components/CrearSeries'
import CrearSeccion from './components/CrearSeccion'
import Dashboard from './views/Dashboard'
import user from './components/Usuarios.vue'
import Inventory from './components/Inventario.vue'
import MenuDocumentos from "./components/MenuDocumentos";
import MenuExpediente from "./components/MenuExpediente";
import MenuSubexpediente from "./components/MenuSubexpediente";
import ReporteDocumentalPorDocumento from "./components/ReporteDocumentalPorDocumento";
import CrearDocumento from "./components/CrearDocumento";
import CrearExpediente from "./components/CrearExpediente";
import CrearPersona from "./components/CrearPersona";
import CrearSubexpediente from "./components/CrearSubexpediente";
import profile from "./views/UserProfile";
import CrearUsuario from "./components/CrearUsuario";
import CrearSubSeccion from "./components/CrearSubSeccion";
import CrearSubSeries from "./components/CrearSubSeries";
import Inicio from './components/Inicio.vue'
import rol from './components/Rol.vue'
import home from './home'
import AuthLayout from './layout/AuthLayout'
import ReporteDocumentalPorExpediente from "./components/ReporteDocumentalPorExpediente";

Vue.use(Router);

const router = new Router({
    mode: 'history',
    routes: [
        {
            path: '/home',
            name: 'home',
            component: Home
        },
        {
            path: '/CrearSubSeries',
            name: 'CrearSubSeries',
            component: CrearSubSeries
        },
        
        {
            path: '/CrearSubSeccion',
            name: 'CrearSubSeccion',
            component: CrearSubSeccion
        },
        
        {
            path: '/CrearSeccion',
            name: 'CrearSeccion',
            component: CrearSeccion
        },
        {
            path: '/CrearSeries',
            name: 'CrearSeries',
            component: CrearSeries
        },
        {
            path: '/usuarios',
            name: 'usuarios',
            component: user
        },
        {
            path: '/inventario',
            name: 'inventario',
            component: Inventory
        },
        {
            path: '/MenuDocumentos',
            name: 'MenuDocumentos',
            component: MenuDocumentos
        },
        {
            path: '/menuExpediente',
            name: 'menuExpediente',
            component: MenuExpediente
        },
        {
            path: '/menuSubexpediente',
            name: 'menuSubexpediente',
            component: MenuSubexpediente
        },
        {
            path: '/reporteDocumentalPorDocumento',
            name: 'reporteDocumentalPorDocumento',
            component: ReporteDocumentalPorDocumento
        },{
            path: '/reporteDocumentalPorExpediente',
            name: 'reporteDocumentalPorExpediente',
            component: ReporteDocumentalPorExpediente
        },
        {
            path: '/crearDocumento',
            name: 'crearDocumento',
            component: CrearDocumento
        },
        {
            path: '/crearExpediente',
            name: 'crearExpediente',
            component: CrearExpediente
        },
        {
            path: '/crearSubexpediente',
            name: 'crearSubexpediente',
            component: CrearSubexpediente
        },

        {
            path: '/crearPersona',
            name: 'crearPersona',
            component: CrearPersona
        },
        {
            path: '/crearUsuario',
            name: 'crearUsuario',
            component: CrearUsuario
        },

        {
            path: '/rol',
            name: 'rol',
            component: rol
        },
        {
            path: '/profile',
            name: 'profile',
            component: profile
        },
    ]
    
});

export default router;

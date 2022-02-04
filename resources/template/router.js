import Vue from 'vue'
import Router from 'vue-router'
import DashboardLayout from './layout/DashboardLayout'
import AuthLayout from './layout/AuthLayout'
Vue.use(Router)

export default new Router({
  linkExactActiveClass: 'active',
  routes: [
    {
      path: '/',
      redirect: 'dashboard',
      component: DashboardLayout,
      children: [
        {
          path: '/dashboard',
          name: 'dashboard',
          // route level code-splitting
          // this generates a separate chunk (about.[hash].js) for this route
          // which is lazy-loaded when the route is visited.
          component: () => import(/* webpackChunkName: "demo" */ './views/Dashboard.vue')
        },
        {
          path: '/icons',
          name: 'icons',
          component: () => import(/* webpackChunkName: "demo" */ './views/Icons.vue')
        },
        {
          path: '/CrearSeccion',
          name: 'CrearSeccion',
          component: () => import(/* webpackChunkName: "demo" */ './views/CrearSeccion.vue')
        },
        {
          path: '/CrearSeries',
          name: 'CrearSeries',
          component: () => import(/* webpackChunkName: "demo" */ './views/Icons.vue')
        },
        {
          path: '/profile',
          name: 'profile',
          component: () => import(/* webpackChunkName: "demo" */ './views/UserProfile.vue')
        },
        {
          path: '/maps',
          name: 'maps',
          component: () => import(/* webpackChunkName: "demo" */ './views/Maps.vue')
        },
        {
          path: '/tables',
          name: 'tables',
          component: () => import(/* webpackChunkName: "demo" */ './views/Tables.vue')
        },
          {
              path: '/ejemplo',
              name: 'Ejemplo',
              component: () => import(/* webpackChunkName: "demo" */ './components/Ejemplo.vue')
          },

          {
            path: '/inicio',
            name: 'inicio',
            component: () => import(/* webpackChunkName: "demo" */ './components/Inicio.vue')
        },

        {
          path: '/usuarios',
          name: 'usuarios',
          component: () => import(/* webpackChunkName: "demo" */ './components/Usuarios.vue')
      },
      {
        path: '/inventario',
        name: 'inventario',
        component: () => import(/* webpackChunkName: "demo" */ './components/Inventario.vue')
      },
      {
        path: '/rol',
        name: 'rol',
        component: () => import(/* webpackChunkName: "demo" */ './components/Rol.vue')
      },

      {
        path: '/menuExpediente',
        name: 'Menu Expedientessssssss',
        component: () => import(/* webpackChunkName: "demo" */ './components/MenuExpediente.vue')
      },          
      ]
    },
    {
      path: '/loginV2',
      name: 'LoginV2',
      component: () => import(/* webpackChunkName: "demo" */ './components/LoginV2.vue')
  },
    {
      path: '/',
      redirect: 'login',
      component: AuthLayout,
      children: [
        {
          path: '/login',
          name: 'login',
          component: () => import(/* webpackChunkName: "demo" */ './views/Login.vue')
        },
        {
          path: '/register',
          name: 'register',
          component: () => import(/* webpackChunkName: "demo" */ './views/Register.vue')
        }
      ]
    }
  ]
})

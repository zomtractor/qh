import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'index',
    component: () => import( '../views/index'),
  },
  {
    path: '/login',
    name: 'login',
    component: () => import( '../views/login/index'),
  },
  {
    path: '/register',
    name: 'register',
    component: () => import( '../views/login/register.vue'),
  },
  {
    path: '/email',
    name: 'email',
    component: () => import( '../views/login/email.vue'),
  },  {
    path: '/token/:token',
    name: 'token',
    component: () => import( '../views/login/token.vue'),
  },
  {
    path: '/jobSeeker',
    name: 'jobSeeker',
    component: () => import( '../views/jobseeker/index'),
  },  {
    path: '/enterprise',
    name: 'enterprise',
    component: () => import( '../views/enterprise/index'),
  },
  {
    path: '/communicate',
    component: () => import('../views/jobseeker/message.vue')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router

<template>
  <div id="app">
    <keep-alive>
      <router-view/>
    </keep-alive>
    <tabbar class="fs-tabbar" v-show="$route.meta.navShow">
      <tabbar-item v-for="(nav,index) in navList" :link="nav.link" :key="index" :selected="$route.path === nav.link">
        <i slot="icon" class="fs-iconfont" :class="nav.icon"></i>
        <i slot="icon-active" class="fs-iconfont" :class="nav.iconActive"></i>
        <span slot="label">{{nav.title}}</span>
      </tabbar-item>
    </tabbar>
  </div>
</template>

<script>
export default {
  name: 'App',
  data(){
    return {
      navList: [
        {
          title: '้ฆ้กต',
          link: '/index',
          icon: 'fs-iconfont-shouye-weixuanzhong',
          iconActive: 'fs-iconfont-shouye-xuanzhong'
        }, {
          title: 'ๆ็',
          link: '/me',
          icon: 'fs-iconfont-wode-weixuanzhong',
          iconActive: 'fs-iconfont-wode-xuanzhong'
        }
      ]
    }
  }
}
</script>

<style lang="less">
@import "./assets/css/variable.less";
@import "./assets/css/common.less";
</style>


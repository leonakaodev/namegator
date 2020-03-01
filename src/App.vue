<template>
    <div>
        <div id="slogan" class="text-center">
            <h1>NameGator</h1>
            <br>
            <h6 class="text-secondary">Gerando nomes utlizando Vue.js, GraphQL e Node</h6>  
        </div>
        <div id="main">
            <div class="container">
                <div class="row">
                    <div class="col-md">
                        <h5>Prefixos <span class="badge badge-info">0</span></h5>
                        <div class="card">
                            <div class="card-body">
                                <ul class="list-group">
                                    <li v-for="prefix in prefixes" :key="prefix" class="list-group-item">
                                        {{prefix}}
                                    </li>
                                </ul>
                                <br>
                                <input class="form-control" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="col-md">
                        <h5>Sufixos <span class="badge badge-info">0</span></h5>
                        <div class="card">
                            <div class="card-body">
                                <ul class="list-group">
                                    <li v-for="sufix in sufixes" :key="sufix" class="list-group-item">
                                        {{sufix}}
                                    </li>
                                </ul>
                                <br>
                                <input class="form-control" type="text">
                            </div>
                        </div>
                    </div>
                </div>
                <br>
                <h5> Domínios <span class="badge badge-info">{{domains.length || 0}}</span></h5>
                <div class="card">
                    <div class="card-body">
                        <ul class="list-group">
                            <li v-for="domain in domains" :key="domain" class="list-group-item">
                                {{domain}}
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import "bootstrap/dist/css/bootstrap.css"
import "font-awesome/css/font-awesome.css"

export default {
    name: 'App',
    data: function(){
        return {
            prefixes: ['Air', 'Jet', 'Flight'],
            sufixes: ['Hub', 'Station', 'Mart'],
        }
    },
    computed: {
        domains(){
            let domains = [];

            this.prefixes.forEach(prefix => {
                this.sufixes.forEach(sufix => { 
                    domains.push(prefix + sufix);
                });
            });

            return domains; 
        }
    }
}
</script>

<style>
#slogan {
    margin-top: 30px;
    margin-bottom: 30px;
}


#main {
    padding-top: 30px;
    padding-bottom: 30px;
}
</style>
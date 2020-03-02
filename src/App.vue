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
                        <h5>Prefixos <span class="badge badge-info">{{prefixes.length}}</span></h5>
                        <div class="card">
                            <div class="card-body">
                                <ul class="list-group">
                                    <li v-for="prefix in prefixes" :key="prefix" class="list-group-item">
										<div class="row">
											<div class="col-md">
												{{prefix}}
											</div>
											<div class="col-md text-right">
												<button class="btn btn-info" @click="deletePrefix(prefix)"><span class="fa fa-trash"></span></button>
											</div>
										</div>
									</li>
                                </ul>
                                <br>
								<div class="input-group">
									<input type="text" class="form-control" @keyup.enter="addPrefix(prefix)" v-model="prefix" placeholder="Digite o prefixo">
									<div class="input-group-append">
										<button class="btn btn-info" @click="addPrefix(prefix)"><span class="fa fa-plus"></span></button>
									</div>
								</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md">
                        <h5>Sufixos <span class="badge badge-info">{{sufixes.length}}</span></h5>
                        <div class="card">
                            <div class="card-body">
                                <ul class="list-group">
                                    <li v-for="sufix in sufixes" :key="sufix" class="list-group-item">
                                        <div class="row">
											<div class="col-md">
												{{sufix}}
											</div>
											<div class="col-md text-right">
												<button class="btn btn-info" @click="deleteSufix(sufix)"><span class="fa fa-trash"></span></button>
											</div>
										</div>
                                    </li>
                                </ul>
                                <br>
								<div class="input-group">
									<input type="text" class="form-control" @keyup.enter="addSufix(sufix)" v-model="sufix" placeholder="Digite o sufixo">
									<div class="input-group-append">
										<button class="btn btn-info" @click="addSufix(sufix)"><span class="fa fa-plus"></span></button>
									</div>
								</div>
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
import "bootstrap/dist/css/bootstrap.css";
import "font-awesome/css/font-awesome.css";

export default {
	name: "App",
	data: function(){
		return {
			prefixes: ["Air", "Jet", "Flight"],
			sufixes: ["Hub", "Station", "Mart"],
			prefix: "",
			sufix: "",
		};
	},
	computed: {
		domains(){
			let domains = [];

			for(const prefix of this.prefixes){
				for(const sufix of this.sufixes){
					domains.push(prefix + sufix);
				}
			}

			return domains; 
		}
	},
	methods: {
		addPrefix: function(prefix){
			this.prefixes.push(prefix);
			this.prefix = "";
		},
		addSufix: function(sufix){
			this.sufixes.push(sufix);
			this.sufix = "";
		},
		deletePrefix: function(prefix){
			this.prefixes.splice(this.prefixes.indexOf(prefix), 1);
		},
		deleteSufix: function(sufix){
			this.sufixes.splice(this.prefixes.indexOf(sufix), 1);
		}
	}
};
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
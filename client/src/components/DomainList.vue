<template>
    <div id="main">
    <div class="container">
            <div class="row">
                <div class="col-md">
                    <AppItemList title="Prefixos" :items="prefixes" @addItem="addPrefix" @deleteItem="deletePrefix"></AppItemList>
                </div>
                <div class="col-md">
                    <AppItemList title="Sufixos" :items="sufixes" @addItem="addSufix" @deleteItem="deleteSufix"></AppItemList>
                </div>
            </div>
            <br>
            <h5> Domínios <span class="badge badge-info">{{domains.length || 0}}</span></h5>
            <div class="card">
                <div class="card-body">
                    <ul class="list-group">
                        <li v-for="domain in domains" :key="domain.nome" class="list-group-item">
                            <div class="row">
                                <div class="col-md">
                                    {{ domain.name }}
                                </div>
                                <div class="col-md text-right">
                                    <a class="btn btn-info" :href="domain.checkout" target="blank">
                                        <span class="fa fa-shopping-cart"></span>
                                    </a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import AppItemList from "./AppItemList";
import axios from "axios/dist/axios";

export default {
	name: "DomainList",
	data: function(){
		return {
			prefixes: [],
			sufixes: [],
		};
	},
	components: {
		AppItemList
	},
	computed: {
		domains(){
			let domains = [];

			for(const prefix of this.prefixes){
				for(const sufix of this.sufixes){
					const name = prefix+sufix;
					const url = name.toLowerCase();
					const checkout = `https://checkout.hostgator.com.br/?a=add&sld=${url}&tld=.com.br`;
					domains.push({
						name,
						checkout
					});
				}
			}

			return domains; 
		}
	},
	methods: {
		addPrefix: function(prefix){
			this.prefixes.push(prefix);
		},
		addSufix: function(sufix){
			this.sufixes.push(sufix);
		},
		deletePrefix: function(prefix){
			this.prefixes.splice(this.prefixes.indexOf(prefix), 1);
		},
		deleteSufix: function(sufix){
			this.sufixes.splice(this.prefixes.indexOf(sufix), 1);
		}
	},
	async created(){
		const response = await axios({
			url: "http://localhost:4000",
			method: "post",
			data: {
				query: `
					{
						prefixes: items(type: "prefix") {
							description
						}
						sufixes: items (type: "sufix") {
							description
						}
					}
				`
			}
		});

		const query = response.data;
		this.prefixes = query.data.prefixes.map(prefix => prefix.description);
		this.sufixes = query.data.sufixes.map(sufix => sufix.description);
	}
};
</script>

<style>
#main {
	background-color: #E7E7E7;
    padding-top: 30px;
    padding-bottom: 30px;
}
</style>
CLUSTER_NAME=platform

up:
	@echo "Bootstrapping platform..."
	./scripts/create-cluster.sh
	./scripts/install-argocd.sh
	./scripts/bootstrap-argocd-apps.sh https://github.com/mmastersvz/platform-gitops.git

down:
	k3d cluster delete $(CLUSTER_NAME)

argocd-password:
	kubectl -n argocd get secret argocd-initial-admin-secret \
	-o jsonpath="{.data.password}" | base64 -d && echo

.PHONY: plan
plan:
	@cd terraform; \
		terraform init; \
		terraform plan

.PHONY: deploy
deploy:
	@cd terraform; \
		terraform init; \
		terraform apply -auto-approve


.PHONY: destroy
destroy:
	@cd terraform; \
		terraform init; \
		terraform destroy -auto-approve && \
		rm -rf .terraform terraform.tfstate terraform.tfstate.backup


.PHONY: provision
provision:
	@cd ansible; \
		ansible-playbook -i inventory/aws playbook.yml

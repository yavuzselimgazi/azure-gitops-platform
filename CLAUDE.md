# Proje: azure-gitops-platform

## Kim çalışıyor, neden
Yavuz Selim Gazi çalışıyor. Almanya'da (Villingen-Schwenningen,
Baden-Württemberg) yaşıyor, 10+ yıl IT-Administrator/sysadmin
geçmişi var (Windows Server, Active Directory, network altyapısı).
Şu an Cloud/DevOps Engineer rolüne geçiş yapıyor. Elinde AZ-104,
CKA ve HashiCorp Terraform Associate sertifikaları var.

Bu proje, iş başvurularında ve mülakatlarda gösterilecek GERÇEK
bir portföy projesi. Amaç sadece "çalışan bir şey" değil,
mülakatta HER SATIRIN "neden böyle yaptın" sorusuna cevap
verilebilmesi.

## ÇALIŞMA KURALLARI — Bunlara kesinlikle uy
1. Küçük adımlarla ilerle. Bir adımı bitirip ONAY almadan
   bir sonraki adıma GEÇME.
2. Her komutu/kod bloğunu YAZARKEN kısaca açıkla: ne yapıyor,
   neden bu şekilde.
3. Kod bloklarını sessizce üretip "kabul et" moduna sokma —
   kullanıcı bunu ELLE anlayarak öğreniyor, otomatik pilot değil.
4. Terraform kodunda: her zaman `terraform validate` öner,
   IAM/RBAC izinlerini mutlaka aşırı-izin (wildcard) açısından
   kontrol et — AI'nın Terraform'da halüsinasyon/eski sözdizimi
   üretme riski yüksek, bu yüzden ekstra dikkatli ol.
5. Yanıtları TÜRKÇE ver.
6. Maliyet bilinci: Azure kaynaklarını gereksiz açık bırakma,
   oturum bitince `terraform destroy` hatırlat.

## Mimari — Genel Akış
Terraform → AKS cluster + VNet + Key Vault + ArgoCD kurulumunu
yapar (altyapı katmanı). Helm chart'lar hem kendi örnek uygulama
için hem de Prometheus/Grafana (kube-prometheus-stack) kurulumu
için kullanılıyor. GitHub Actions CI: build → test → image push
→ manifest/values güncelle. ArgoCD bunu Git'ten otomatik senkronize
ediyor (GitOps / pull model). Prometheus + Grafana her şeyi izliyor.

Repo yapısı:
- infra/       → Terraform kodu
- charts/      → Helm chart'lar (my-app + monitoring values)
- manifests/   → ArgoCD Application tanımları
- app/         → Örnek uygulama + Dockerfile
- .github/workflows/ → CI pipeline

Bilinçli olarak kullanılmayanlar: Ansible (bu proje tamamen
Kubernetes-native, VM provisioning yok), HashiCorp Vault (Azure
Key Vault yeterli, tutarlı Azure-native hikaye için), Keycloak
(K8s RBAC + Azure AD yeterli).

## Mülakat Hedefi — Unutma
Proje bitince kasıtlı bir incident (ör. yanlış resource limit
→ OOMKilled) yaratılıp debug süreci README'ye belgelenecek.
Bu, "sadece araç kullandım" değil "gerçek bir sorunu çözdüm"
hikayesi için kritik — atlanmamalı.

## Şu ana kadar tamamlananlar
- Azure hesabı + GitHub repo (yavuzselimgazi/azure-gitops-platform) hazır
- providers.tf + main.tf (resource group) yazıldı, GitHub'a push edildi
- `terraform apply` ile ilk resource group oluşturuldu (veya oluşturuluyor)
- Sıradaki adım: remote state (Storage Account backend) kurulumu

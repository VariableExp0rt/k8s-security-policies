package cis_5_1_5

import data.lib.kubernetes

violation[msg] {
    kubernetes.pods[pod]
    is_service_account_disallowed(pod)
    msg := kubernetes.format(sprintf("%v: %v - Use of default service account is not allowed'", [kubernetes.kind, kubernetes.name]))
}

violation[msg] {
    kubernetes.serviceaccounts[serviceaccount]
    is_service_account_default(serviceaccount)
    is_automount_serviceaccount_token_enabled(serviceaccount)
    msg := kubernetes.format(sprintf("ServiceAccount: %v. Automount Service account token must be set to false.", [kubernetes.name]))
}

is_service_account_disallowed(pod) {
    pod.spec.serviceAccountName == "default"
}

is_service_account_disallowed(pod) {
    pod.spec.serviceAccount == "default"
}

is_service_account_default(serviceaccount) {
    serviceaccount.metadata.name == "default"
}

is_automount_serviceaccount_token_enabled(serviceaccount) {
    serviceaccount.automountServiceAccountToken == true
}

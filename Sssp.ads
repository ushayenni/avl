#include<stdio.h>
int b[10];
int a[10][10];
void sp(int i,int k,int n){
    for(int j=1;j<=n;j++){
        if(i==j || j==1)
        continue;
        if(a[i][j]!=0){
            if(b[j]>k+a[i][j] || b[j]==0){
                b[j]=k+a[i][j];
                sp(j,b[j],n);
            }
        }
    }
}
void add(int i,int j,int l){
    a[i][j]=l;
    a[j][i]=l;
}
int main(){
    int n;
    printf("Enter a size: ");
    scanf("%d",&n);
    for(int i=1;i<=n;i++){
        for(int j=1;j<=n;j++){
            if(i>j)
            continue;
            int l;
            printf("Enter a relation blw %d and %d: ",i,j);
            scanf("%d",&l);
            if(l!=0)
            add(i,j,l);
        }
    }
    sp(1,a[1][1],n);
    printf("The shortest paths are: \n");
    for(int i=1;i<=n;i++){
        printf("1 --> %d : %d\n",i,b[i]);
    }
    return 0;
}

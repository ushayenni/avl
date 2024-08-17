#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
typedef struct node
{
int data;
struct node *left,*right;
int ht;
}node;
node *insert(node *,int);
node *delete(node *,int);
void *preorder(node *);
void *inorder(node *);
node *rightrotation(node *);
node *leftrotation(node *);
node *RR(node *);
node *LL(node *);
node *RL(node *);
node *LR(node *);
int BH(node *);
int height(node *);
void main()
{
    node *root=NULL;
    int i,n,x,op;
    do
    {
        printf("\n1.Create\n2.Insert\n3.Delete\n4.Print\n5.Quit");
        printf("\nEnter option:");
        scanf("%d",&op);
        switch(op)
        {
            case 1:
                printf("Enter no of elements : ");
                scanf("%d",&n);
                printf("Enter Tree data: ");
                root=NULL;
                for(i=0;i<n;i++)
                {
                    scanf("%d",&x);
                    root=insert(root,x);
                }
                break;
            case 2:
                printf("Enter data:");
                scanf("%d",&x);
                root=insert(root,x);
                break;
            case 3:
                printf("Enter data:");
                scanf("%d",&x);
                root=delete(root,x);
                break;
            case 4:
                printf("\n\nPreorder Sequence:\n");
                preorder(root);
                printf("\n\nInorder Sequence:\n");
                inorder(root);
                break;
        }
    }while(op!=5);
}
node *insert(node *T,int x)
{
    if(T==NULL)
    {
        T=(node *)malloc(sizeof(node));
        T->data=x;
        T->left=NULL;
        T->right=NULL;
    }
    else if(x>T->data)
    {
        T->right=insert(T->right,x);
        if(BH(T)==-2)
        {
            if(x>T->right->data)
                T=RR(T);
            else
                T=LR(T);
        }
    }
    else if(x<T->data)
    {
        T->left=insert(T->left,x);
        if(BH(T)==2)
        {
            if(x<T->left->data)
                T=LL(T);
            else
                T=RL(T);
        }
    }
    T->ht=height(T);
    return(T);
}
node *delete(node *T,int x)
{
    node *p;
    if(T==NULL)
    {
        return NULL;
    }
    else if(x>T->data)
    {
        T->right=delete(T->right,x);
        if(BH(T)==2)
        {
            if(BH(T->left)>=0)
                T=LL(T);
            else
                T=RL(T);
        }
    }
    else if(x<T->data)
    {
        T->left=delete(T->left,x);
        if(BH(T)==-2)
        {
            if(BH(T->right)<=0)
                T=RR(T);
            else
                T=LR(T);
        }
    }
    else
    {
        if(T->right!=NULL)
        {
            p=T->right;
            while((p->left)!=NULL)
                        p=p->left;
            T->data=p->data;
            T->right=delete(T->right,p->data);
            if(BH(T)==-2)
            {
                if (BH(T->left)>=0)
                    T=LL(T);
                else
                    T=RL(T);
            }
        }
        else
            return(T->left);
    }
    T->ht=height(T);
    return(T);
}
int height(node *T)
{
    int lh,rh;
    if(T==NULL)
        return 0;
    if(T->left == NULL)
        lh=0;
    else
        lh=1+T->left->ht;preorder(T->left);
    if(T->right == NULL)
        rh=0;
    else
        rh=1+T->right->ht;
    if(lh>rh)
        return(lh);
    else
        return(rh);
}
node *rotateright(node *x)
{
    node *y;
    y=x->left;
    x->left=y->left;
    y->right=x;
    x->ht=height(x);
    y->ht=height(y);
    return(y);
}
node *rotateleft(node *x)
{
    node *y;
    y=x->right;
    x->right=y->left;
    y->left=x;
    x->ht=height(x);
    y->ht=height(y);
    return(y);
}
node *RR(node *T)
{
    T=rotateleft(T);
    printf("\nSingle Leftpreorder(T->left); rotation is used...\n");
    return(T);
}
node *LL(node *T)
{
    T=rotateright(T);
    printf("\nSingle right rotation is used...\n");
    return(T);
}
node *LR(node *T)
{
    T->left=rotateleft(T->left);
    T=rotateright(T);
    printf("\nDouble left-right rotation is used...\n");
    return(T);
}
node *RL(node *T)
{
    T->right=rotateleft(T->right);
    T=rotateleft(T);
    printf("\nDouble right-left rotation is used...\n");
    return(T);
}
int BH(node *T)
{
int lh,rh;
if(T==NULL)
    return(0);
if(T->left==NULL)
    lh=0;
else
     lh=1+T->left->ht;
if(T->right == NULL)
    rh=0;
else
    rh=1+T->right->ht;
return(lh-rh);
}
void *preorder(node *T)
{
    if(T!=NULL)
    {
        printf("%d(Bf=%d)",T->data,BH(T));
        preorder(T->left);
        preorder(T->right);
    }
}
void *inorder(node *T)
{
    if(T!=NULL)
    {
        inorder(T->left);
        printf("%d(Bf=%d)",T->data,BH(T));
        inorder(T->right);
    }
}
